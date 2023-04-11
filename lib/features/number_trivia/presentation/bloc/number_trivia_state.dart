import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState(); //[List props = const <dynamic>[]]
}

class Empty extends NumberTriviaState{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Loading extends NumberTriviaState{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Loaded extends NumberTriviaState{
  Loaded(this.trivia);
  final NumberTrivia trivia;

  @override
  List<Object?> get props => [trivia];
}


class Error extends NumberTriviaState{
  Error(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
