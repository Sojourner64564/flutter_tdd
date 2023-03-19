import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}