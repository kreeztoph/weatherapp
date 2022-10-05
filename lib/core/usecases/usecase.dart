import 'package:dartz/dartz.dart';
import 'package:weather_app/operation.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Operation> call(Params params);
}
