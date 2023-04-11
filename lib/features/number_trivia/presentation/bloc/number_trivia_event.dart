import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent(); //[List props = const <dynamic>[]]
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  GetTriviaForConcreteNumber(this.numberString);

  final String numberString;

  @override
  List<Object?> get props => [numberString];
}


class GetTriviaForRandomNumber extends NumberTriviaEvent{



  @override
  List<Object?> get props => throw UnimplementedError();

}