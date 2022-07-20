import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String weathers;
  final double? latitude;
  final double? longitude;
  final String weatherDescription;
  final double? mainTemp;
  final double? feelsLike;
  final String country;
  final String city;

  const Weather(
      {required this.weathers,
      required this.latitude,
      required this.longitude,
      required this.weatherDescription,
      required this.mainTemp,
      required this.feelsLike,
      required this.country,
      required this.city});

  @override
  List<Object?> get props => [
        weathers,
        latitude,
        longitude,
        weatherDescription,
        mainTemp,
        feelsLike,
        country,
        city,
      ];
}
