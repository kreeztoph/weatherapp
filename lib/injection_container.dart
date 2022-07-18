import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_date_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_concrete_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_city.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather
  //cubit
  sl.registerFactory(
    () => WeatherCubit(
        getConcreteWeather: sl(), getWeatherByCity: sl(), inputConverter: sl()),
  );

  //usecases
  sl.registerLazySingleton(
    () => GetWeatherByCity(sl()),
  );
  sl.registerLazySingleton(
    () => GetConcreteWeather(sl()),
  );

  //repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //Core - Weather
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkConnectionImpl(
      sl(),
    ),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
