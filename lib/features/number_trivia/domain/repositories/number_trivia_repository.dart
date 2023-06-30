
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failures.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number); //мб int?
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}