part of 'either.dart';

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Left<L, R> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  Either<L, T> flatMap<T>(Callback<Either<L, T>, R> f) => Left(value);

  @override
  T fold<T>(Callback<T, L> left, Callback<T, R> right) => left(value);

  @override
  void forEach(Callback<void, R> effect) {}

  @override
  R getOrElse(R Function() orElse) => orElse();

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  Either<L, T> map<T>(Callback<T, R> f) => Left(value);

  @override
  Either<T, R> mapLeft<T>(Callback<T, L> f) => Left(f(value));

  @override
  Either<L, T> pure<T>(Callback<Either<L, T>, R> f) => Left(value);

  @override
  Either<R, L> swap() => Right(value);

  @override
  R? toNullable() => null;

  @override
  String toString() => 'Left(value: $value)';

  @override
  R operator |(R other) => other;
}
