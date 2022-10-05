import 'package:dartz/dartz.dart';
import 'package:weather_app/operation.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Operation> getConcreteWeather(
    double concLat,
    double concLong,
  );
  Future<Operation> getWeatherByCity(
    String city,
  );
}
