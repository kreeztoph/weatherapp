import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputConverter {
  Either<Failure, double> stringtoUnsignedInteger(String str) {
    try {
      return Right(double.parse(str));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}




// for other cases when the decimal is not neeeded use this 
// class InputConverter {
//   Either<Failure, int> stringtoUnsignedInteger(String str) {
//    try{
// final integer = int.parse(str);
// if(integer < 0) throw FormatException();
// return Right(integer);
// }on FormatException{
// return Left(InvalidInputFailure());}
// }