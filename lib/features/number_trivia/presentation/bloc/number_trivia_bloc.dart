import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failures.dart';
import 'package:flutter_tdd/core/usecases/usecases.dart';
import 'package:flutter_tdd/core/util/input_converter.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) :super(Empty()){
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;


  void _onGetTriviaForConcreteNumber(GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) {
    final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);

     inputEither.fold((failure) => emit(Error(INVALID_INPUT_FAILURE_MESSAGE)), (integer) async {
       emit(Loading());
        final failureOrTrivia = await getConcreteNumberTrivia.call(Params(number: integer));
         _eitherLoadedOrErrorState(failureOrTrivia);
      },
    );
  }

  void _onGetTriviaForRandomNumber(GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async{
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
     _eitherLoadedOrErrorState(failureOrTrivia);
  }


  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia) {
    emit(failureOrTrivia.fold((failure) => Error(_mapFailureToMessage(failure)), (trivia) => Loaded(trivia),));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
