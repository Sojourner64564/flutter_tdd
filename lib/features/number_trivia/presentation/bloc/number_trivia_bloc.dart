//import 'dart: async';
import 'package:bloc/bloc.dart';
import 'package:flutter_tdd/core/util/input_converter.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(
    super.initialState,
    GetConcreteNumberTrivia concrete,
    GetRandomNumberTrivia random,
    this.inputConverter,
  )   : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) => UnimplementedError(),
      );
    }
  }
}
