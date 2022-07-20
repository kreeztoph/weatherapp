// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

const String DEFAULT_MESSAGE = 'Get a weather report';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: SingleChildScrollView(child: buildBody()),
    );
  }
}

BlocProvider<WeatherCubit> buildBody() {
  return BlocProvider(
    create: (_) => sl<WeatherCubit>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return MessageDisplay(
                    message: DEFAULT_MESSAGE,
                  );
                } else if (state is WeatherLoading) {
                  return LoadingCircle();
                } else if (state is WeatherLoaded) {
                  return WeatherDisplay(mainWeather: state.weather);
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else {
                  return MessageDisplay(message: DEFAULT_MESSAGE);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            WeatherControl(),
          ],
        ),
      ),
    ),
  );
}

class WeatherControl extends StatefulWidget {
  const WeatherControl({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherControl> createState() => _WeatherControlState();
}

class _WeatherControlState extends State<WeatherControl> {
  final controller = TextEditingController();
  late String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  (30.0),
                ),
              ),
              hintText: 'Input a valid city'),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) => dispatchWeatherByCity(context),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () => dispatchWeatherByCity(context),
                child: const Text('Weather by City'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {},
                child: const Text('Weather by Device Location'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchWeatherByCity(BuildContext context) {
    controller.clear();
    BlocProvider.of<WeatherCubit>(context).getWeatherCity(inputStr);
  }
}
