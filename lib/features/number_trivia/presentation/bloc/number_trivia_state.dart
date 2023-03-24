import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]);
}

class InitialNumberTriviaState extends NumberTriviaState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}