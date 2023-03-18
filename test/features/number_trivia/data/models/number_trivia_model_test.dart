import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    "should a subclass of NumberTrivia entity",
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );
}
