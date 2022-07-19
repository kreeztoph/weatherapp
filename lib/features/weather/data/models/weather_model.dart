import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required String weather,
    required double latitude,
    required double longitude,
    required String weatherDescription,
    required double mainTemp,
    required double feelsLike,
    required String country,
    required String city,
  }) : super(
            weather: weather,
            latitude: latitude,
            longitude: longitude,
            weatherDescription: weatherDescription,
            mainTemp: mainTemp,
            feelsLike: feelsLike,
            country: country,
            city: city);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        weather: json["weather"]["main"],
        latitude: (json['coord']['lat'] as num).toDouble(),
        longitude: (json['coord']['long'] as num).toDouble(),
        weatherDescription: json['weather']['description'],
        mainTemp: (json['main']['temp'] as num).toDouble(),
        feelsLike: (json['main']['feels_like'] as num).toDouble(),
        country: json['sys']['country'],
        city: json['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'weather': weather,
      'latitude': latitude,
      'longitude': longitude,
      'weatherDescription': weatherDescription,
      'mainTemp': mainTemp,
      'feelsLike': feelsLike,
      'country': country,
      'city': city,
    };
  }
}
