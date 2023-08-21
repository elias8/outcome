import 'package:outcome/outcome.dart';
import 'package:test/test.dart';

void main() {
  group('$Either', () {
    group('$Left', () {
      test('constructor should instantiate with correct value and type', () {
        expect(const Either<int, String>.left(1), const Left<int, String>(1));
        expect(left<int, String>(1), const Left<int, String>(1));
        expect(const Left<int, String>(1).hashCode, 1.hashCode);
        expect(const Left<int, String>(1).value, 1);
      });

      group('flatMap', () {
        test('should return updated type and same value', () {
          const value = Either<String, int>.left('10');
          expect(
            value.flatMap<String>((p) => Right('v:$p')),
            const Left<String, String>('10'),
          );
        });
      });

      group('fold', () {
        test('should call left callback', () {
          const either = Either<bool, bool>.left(true);
          final value = either.fold((p) => p, (p) => false);
          expect(value, isTrue);
        });
      });

      group('forEach', () {
        test('should not call effect callback', () {
          int? count;
          const either = Either<String, int>.left('');
          either.forEach((p) => count = p);

          expect(count, isNull);
        });
      });

      group('getOrElse', () {
        test('should return value of a callback result', () {
          const either = Either<int, String>.left(10);
          expect(either.getOrElse(() => '100'), '100');
        });
      });

      group('isLeft', () {
        test('should return true', () {
          expect(const Either<int, String>.left(10).isLeft(), isTrue);
        });
      });

      group('isRight', () {
        test('should return false', () {
          expect(const Either<int, String>.left(10).isRight(), isFalse);
        });
      });

      group('map', () {
        test('should return same value with changed type', () {
          const either = Either<int, double>.left(10);
          final value = either.map<String>((p) => '$p');
          expect(value, const Left<int, String>(10));
        });
      });

      group('mapLeft', () {
        test('should return new value by mapping current value to a new one',
            () {
          const either = Either<int, double>.left(10);
          expect(
            either.mapLeft<String>((p) => '$p'),
            const Left<String, double>('10'),
          );
        });
      });

      group('pure', () {
        test('should return same value with changed type', () {
          const either = Either<int, String>.left(10);
          final pure = either.pure<double>((p) => const Right(5.5));
          expect(pure, const Left<int, double>(10));
        });
      });

      group('swap', () {
        test('should return Right with swapped type and current value', () {
          const either = Either<int, String>.left(10);
          expect(either.swap(), const Right<String, int>(10));
        });
      });

      group('toNullable', () {
        test('should return null', () {
          const either = Either<int, String>.left(10);
          expect(either.toNullable(), isNull);
        });
      });

      group('toString', () {
        test('should return correct string', () {
          const either = Either<int, String>.left(10);
          expect(either.toString(), 'Left(value: 10)');
        });
      });

      group('| operator', () {
        test('should return other value', () {
          const either = Either<int, String>.left(10);
          expect(either | 'other', 'other');
        });
      });
    });

    group('$Right', () {
      test('constructor should instantiate with correct value and type', () {
        expect(const Either<String, int>.right(1), const Right<String, int>(1));
        expect(right<String, int>(1), equals(const Right<String, int>(1)));
        expect(const Right<String, int>(1).hashCode, 1.hashCode);
        expect(const Right<String, int>(1).value, 1);
      });

      group('flatMap', () {
        test('should return with updated type and value', () {
          const value = Either<int, String>.right('10');
          expect(
            value.flatMap<String>((p) => Right('v:$p')),
            const Right<int, String>('v:10'),
          );
        });
      });

      group('fold', () {
        test('should call right callback', () {
          const either = Either<bool, bool>.right(true);
          final value = either.fold((p) => false, (p) => p);
          expect(value, isTrue);
        });
      });

      group('forEach', () {
        test('should call effect callback', () {
          late int count;
          const either = Either<String, int>.right(10);
          either.forEach((p) => count = p);
          expect(count, 10);
        });
      });

      group('getOrElse', () {
        test('should return current value', () {
          const either = Either<String, int>.right(10);
          expect(either.getOrElse(() => 100), 10);
        });
      });

      group('isLeft', () {
        test('should return false', () {
          expect(const Either<int, String>.right('10').isLeft(), isFalse);
        });
      });

      group('isRight', () {
        test('should return true', () {
          expect(const Either<int, String>.right('10').isRight(), isTrue);
        });
      });

      group('map', () {
        test('should return mapped value with mapped type', () {
          const either = Either<int, double>.right(10);
          expect(either.map((p) => '$p'), const Right<int, String>('10.0'));
        });
      });

      group('mapLeft', () {
        test('should return updated type with same value', () {
          const either = Either<int, double>.right(10);
          final value = either.mapLeft<String>((p) => '$p');
          expect(value, const Right<String, double>(10));
        });
      });

      group('pure', () {
        test('should return updated value with updated type', () {
          const either = Either<String, int>.right(10);
          final pure = either.pure<double>((p) => Right(p / 2));
          expect(pure, const Right<String, double>(5));
        });
      });

      group('swap', () {
        test('should return Left with swapped type and current value', () {
          const either = Either<int, String>.right('10');
          expect(either.swap(), const Left<String, int>('10'));
        });
      });

      group('toNullable', () {
        test('should return value', () {
          const either = Either<String, int>.right(10);
          expect(either.toNullable(), 10);
        });
      });

      group('toString', () {
        test('should return correct string', () {
          const either = Either<String, int>.right(10);
          expect(either.toString(), 'Right(10)');
        });
      });

      group('| operator', () {
        test('should return current value', () {
          const either = Either<String, int>.right(10);
          expect(either | 100, 10);
        });
      });
    });
  });
}
