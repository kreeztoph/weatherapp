import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart' as w;
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/operation.dart';

import '../../../../core/error/failure.dart';

class GetConcreteWeather extends UseCase<w.Weather, Params> {
  final WeatherRepository repository;

  GetConcreteWeather(this.repository);

  @override
  Future<Operation> call(Params params) async {
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
