import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error/failure.dart';

class GetConcreteWeather extends UseCase<Weather, Params> {
  final WeatherRepository repository;

  GetConcreteWeather(this.repository);

  @override
  Future<Either<Failure, Weather>> call(Params params) async {
    return await repository.getConcreteWeather(params.concLat, params.concLong);
  }
}

class Params extends Equatable {
  final double concLat;
  final double concLong;

  const Params({
    required this.concLat,
    required this.concLong,
  });

  @override
  List<Object?> get props => [concLat, concLong];
}
