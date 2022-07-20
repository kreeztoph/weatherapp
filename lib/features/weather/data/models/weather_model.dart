import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required String weather,
    required double? latitude,
    required double? longitude,
    required String weatherDescription,
    required double? mainTemp,
    required double? feelsLike,
    required String country,
    required String city,
  }) : super(
            weathers: weather,
            latitude: latitude,
            longitude: longitude,
            weatherDescription: weatherDescription,
            mainTemp: mainTemp,
            feelsLike: feelsLike,
            country: country,
            city: city);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        weather: json["weather"][0]["main"],
        latitude: (json['coord']['lat']).toDouble(),
        longitude: (json['coord']['lon']).toDouble(),
        weatherDescription: json['weather'][0]['description'],
        mainTemp: (json['main']['temp'] / 10).toDouble(),
        feelsLike: (json['main']['feels_like'] / 10).toDouble(),
        country: json['sys']['country'],
        city: json['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'weather': weathers,
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
