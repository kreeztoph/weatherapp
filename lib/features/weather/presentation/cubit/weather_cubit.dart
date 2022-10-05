// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/features/weather/domain/usecases/get_concrete_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_city.dart';
import 'package:weather_app/operation.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/weather.dart';

part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class WeatherCubit extends Cubit<WeatherState> {
  final GetConcreteWeather getConcreteWeather;
  final GetWeatherByCity getWeatherByCity;
  //final InputConverter inputConverter;

  WeatherCubit({
    required this.getConcreteWeather,
    required this.getWeatherByCity,
    //required this.inputConverter,
  }) : super(WeatherInitial());

  Future<void> getConcWeather(double lat, double long) async {
    emit(WeatherLoading());
    final weather =
        await getConcreteWeather(Params(concLat: lat, concLong: long));
    // emit(weather.fold((failure) => Error(message: mapFailureToMessage(failure)),
    //     (weather) => WeatherLoaded(weather: weather)));

    emit(weather.when(
      success: (weather) => WeatherLoaded(weather: weather),
      failure: (failure) => Error(message: mapFailureToMessage(failure)),
    ));
  }

  Future<void> getWeatherCity(String city) async {
    emit(WeatherLoading());
    final weather = await getWeatherByCity(CityParams(city: city));
    // emit(weather.when((failure) => Error(message: mapFailureToMessage(failure)),
    //     (weather) => WeatherLoaded(weather: weather)));
    emit(weather.when(
      success: (weather) => WeatherLoaded(weather: weather),
      failure: (failure) => Error(message: mapFailureToMessage(failure)),
    ));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unxpected Error';
    }
  }
}
