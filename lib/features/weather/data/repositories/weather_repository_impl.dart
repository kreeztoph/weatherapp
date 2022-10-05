// ignore_for_file: prefer_generic_function_type_aliases

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/operation.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart' as f;
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart' as w;
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_date_source.dart';

typedef Future<w.Weather> _ConcreteOrCityChooser();

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
  Future<Operation> getConcreteWeather(double concLat, double concLong) async {
    return await _getWeather(
      () {
        return remoteDataSource.getConcreteWeather(concLat, concLong);
      },
    );
  }

  @override
  Future<Operation> getWeatherByCity(String city) async {
    return await _getWeather(() {
      return remoteDataSource.getWeatherByCity(city);
    });
  }

  Future<Operation> _getWeather(
      _ConcreteOrCityChooser getConcreteOrCity) async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final remoteWeather = await getConcreteOrCity();
        localDataSource.cacheWeatherTrivia(remoteWeather as WeatherModel);
        return Operation.success(remoteWeather);
      } on ServerException {
        return Operation.failure(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Operation.success(localWeather);
      } on CacheException {
        return Operation.failure(CacheFailure());
      }
    }
  }
}
