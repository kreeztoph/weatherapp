import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/operation.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather.dart' as w;
import '../repositories/weather_repository.dart';

class GetWeatherByCity extends UseCase<w.Weather, CityParams> {
  final WeatherRepository repository;

  GetWeatherByCity(this.repository);

  @override
  Future<Operation> call(CityParams params) async {
    return await repository.getWeatherByCity(params.city);
  }
}

class CityParams extends Equatable {
  final String city;

  const CityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
