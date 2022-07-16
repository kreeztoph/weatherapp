import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getConcreteWeather(
    double concLat,
    double concLong,
  );
  Future<Either<Failure, Weather>> getWeatherByCity(
    String city,
  );
}
