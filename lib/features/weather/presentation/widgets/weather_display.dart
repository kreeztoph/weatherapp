import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  const WeatherDisplay({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Text(
            weather.weather,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  weather.feelsLike as String,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
