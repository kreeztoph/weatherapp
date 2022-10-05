import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

part 'operation.freezed.dart';

@freezed
class Operation with _$Operation {
  const factory Operation.success(Weather weather) = _Weather;
  const factory Operation.failure(Failure failure) = _Failure;
  // const factory Operation.type(Type type) = Type;
  // const factory Operation.weathermodel(WeatherModel weatherModel) =
  //     WeatherModel;
  // const factory Operation.serverfailure(ServerFailure serverFailure) =
  //     ServerFailure;
}
