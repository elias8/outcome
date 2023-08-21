import 'package:outcome/outcome.dart';

void main() {
  final result = divide(10, 2);
  result.fold(
    (error) => print('Error is $error'),
    (value) => print('Result is $value'),
  );
}

/// Returns the result of dividing [a] by [b]. If [b] is 0, returns an [Error].
Either<Error, int> divide(int a, int b) {
  if (b == 0) {
    return Left(Error.divisionByZero);
  } else {
    return Right(a ~/ b);
  }
}

/// An error that can occur when dividing two numbers.
enum Error {
  /// Occurs when the divisor is 0.
  divisionByZero,
}
