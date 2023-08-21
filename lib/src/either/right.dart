part of 'either.dart';

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Right<L, R> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  Either<L, T> flatMap<T>(Callback<Either<L, T>, R> f) => f(value);

  @override
  T fold<T>(Callback<T, L> left, Callback<T, R> right) => right(value);

  @override
  void forEach(Callback<void, R> effect) => effect(value);

  @override
  R getOrElse(R Function() orElse) => value;

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  Either<L, T> map<T>(Callback<T, R> f) => Right(f(value));

  @override
  Either<T, R> mapLeft<T>(Callback<T, L> f) => Right(value);

  @override
  Either<L, T> pure<T>(Callback<Either<L, T>, R> f) => f(value);

  @override
  Either<R, L> swap() => Left(value);

  @override
  R? toNullable() => value;

  @override
  String toString() => 'Right($value)';

  @override
  R operator |(R other) => value;
}
