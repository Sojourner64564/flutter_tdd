import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{

}

void main(){
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumbertriviaRepository;


  mockNumbertriviaRepository = MockNumberTriviaRepository();
  usecase = GetConcreteNumberTrivia(mockNumbertriviaRepository);




  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'text');

  test(
    "should get trivia for the number from the repository",
        () async {
          //arrange
          when(mockNumbertriviaRepository.getConcreteNumberTrivia(
              any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          //act
          final result = await usecase.call(params: Params(number: tNumber));
          //assert
          expect(result, Right(tNumberTrivia));
          verify(mockNumbertriviaRepository.getConcreteNumberTrivia(42));
          verifyNoMoreInteractions(mockNumbertriviaRepository);


  },
  );
}
