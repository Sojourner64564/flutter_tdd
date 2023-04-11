import 'dart:convert';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:http/http.dart' as http;


abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}


class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  NumberTriviaRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) => _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl('http://numbersapi.com/random');


  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(Uri.parse(url),  // тут было без юри
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}