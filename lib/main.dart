// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'features/weather/presentation/pages/weather_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.blue.shade500)),
      home: WeatherPage(),
    );
  }
}
