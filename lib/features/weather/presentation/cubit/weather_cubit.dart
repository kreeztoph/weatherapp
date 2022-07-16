import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/util/input_converter.dart';
import 'package:weather_app/features/weather/domain/usecases/get_concrete_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_city.dart';

import '../../domain/entities/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetConcreteWeather getConcreteWeather;
  final GetWeatherByCity getWeatherByCity;
  final InputConverter inputConverter;

  WeatherCubit({
    required this.getConcreteWeather,
    required this.getWeatherByCity,
    required this.inputConverter,
  }) : super(WeatherInitial());

  Future<void> getConcWeather(double lat, double long) async {
    emit(WeatherLoading());
    final weather =
        await getConcreteWeather(Params(concLat: lat, concLong: long));
    emit(WeatherLoaded(weather: weather));
  }

  Future<void> getWeatherCity(String city) async {
    emit(WeatherLoading());
    final weather = await getWeatherByCity(CityParams(city: city));
    emit(WeatherLoaded(weather: weather));
  }
}
