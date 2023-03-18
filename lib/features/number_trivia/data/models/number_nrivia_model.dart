import 'package:flutter/material.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{
  NumberTriviaModel({
    required String text,
    required int number,
}): super(text:text, number:number);


}