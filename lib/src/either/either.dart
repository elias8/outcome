import 'package:meta/meta.dart';

part 'left.dart';
part 'right.dart';

/// Shortcut for `Either.left(value)`.
Either<L, R> left<L, R>(L value) => Left(value);

/// Shortcut for `Either.right(value)`.
Either<L, R> right<L, R>(R value) => Right(value);

/// A function that takes a param with type [Param] and returns a result with
/// type [Answer].
@internal
typedef Callback<Answer, Param> = Answer Function(Param p);

@immutable
sealed class Either<L, R> {
  /// Disables direct instantiation and allow sub-classes to have a `const`
  /// constructor.
  const Either();

  /// Factory constructor for [Left].
  const factory Either.left(L value) = Left<L, R>;

  /// Factory constructor for [Right].
  const factory Either.right(R value) = Right<L, R>;

  /// Returns a new [Either] by chaining a result of [f] callback when the
  /// current [Either] is [Right].
  Either<L, T> flatMap<T>(Callback<Either<L, T>, R> f);

  /// Returns the result of [left] callback when the [Either] is [Right].
  /// And returns the result of [right] callback when the [Either] is
  /// [Left].
  T fold<T>(Callback<T, L> left, Callback<T, R> right);

  /// Calls the given [effect] function when the [Either] is [Right].
  void forEach(Callback<void, R> effect);

  /// Returns [R] when the [Either] is [Right] and returns the result of
  /// [orElse] callback when [Left].
  R getOrElse(R Function() orElse);

  /// Returns `true` if [Either] is [Left].
  bool isLeft();

  /// Returns `true` if [Either] is [Right].
  bool isRight();

  /// Returns a new [Either] by mapping [R] to [T] by using callback [f] to
  /// convert the type when the current [Either] is [Right].
  Either<L, T> map<T>(Callback<T, R> f);

  /// Returns a new [Either] by mapping [L] to [T] by using callback [f] to
  /// convert the type when the current [Either] is [Left].
  Either<T, R> mapLeft<T>(Callback<T, L> f);

  /// Returns a new [Either] by replacing [R] by [T] when the current [Either]
  /// is [Right].
  Either<L, T> pure<T>(Callback<Either<L, T>, R> f);

  /// Returns [Either]<[R],[L]> by swapping the values of [Right] and
  /// [Left].
  Either<R, L> swap();

  /// Returns [R] when the [Either] is [Right] or null when [Left].
  R? toNullable();

  /// Returns [R] when [Either] is [Right] and returns [other] when [Left].
  R operator |(R other);
}
