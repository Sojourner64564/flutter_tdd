//import 'dart: async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(super.initialState);


  @override
  NumberTriviaState get initialState => InitialNumberTriviaState();

  @override
  Stream<NumberTriviaState> mapEventToState(
      NumberTriviaEvent event,
      ) async* {
  }
}
