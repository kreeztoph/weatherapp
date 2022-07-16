import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';

import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getConcreteWeather(
    double concLat,
    double concLong,
  );
  Future<WeatherModel> getWeatherByCity(
    String city,
  );
}

const String API_KEY = '61c9277d9bb796d5f528b9f2fe3d27c5';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getConcreteWeather(double concLat, double concLong) =>
      _getWeatherUrl(
          'https://api.openweathermap.org/data/2.5/weather?lat=$concLat&lon=$concLong&appid=$API_KEY');

  @override
  Future<WeatherModel> getWeatherByCity(String city) => _getWeatherUrl(
      'https://api.openweathermap.org/data/2.5/weather?id=$city&appid=$API_KEY');

  Future<WeatherModel> _getWeatherUrl(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
