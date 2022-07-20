part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => throw UnimplementedError();
}
