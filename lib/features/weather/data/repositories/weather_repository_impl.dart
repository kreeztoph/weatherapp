// ignore_for_file: prefer_generic_function_type_aliases

import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_date_source.dart';

typedef Future<Weather> _ConcreteOrCityChooser();

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Weather>> getConcreteWeather(
      double concLat, double concLong) async {
    return await _getWeather(
      () {
        return remoteDataSource.getConcreteWeather(concLat, concLong);
      },
    );
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String city) async {
    return await _getWeather(() {
      return remoteDataSource.getWeatherByCity(city);
    });
  }

  Future<Either<Failure, Weather>> _getWeather(
      _ConcreteOrCityChooser getConcreteOrCity) async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final remoteWeather = await getConcreteOrCity();
        localDataSource.cacheWeatherTrivia(remoteWeather as WeatherModel);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
