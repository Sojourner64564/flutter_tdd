import 'dart:convert';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixtures_reader.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  mockHttpClient = MockHttpClient();
  dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFaliure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 404));
  }


  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockHttpClient.get(
        Uri(scheme: 'http://numbersapi.com/$tNumber'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response cod is 200 (success)',
        () async {
      //arrange
          setUpMockHttpClientSuccess200();
      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
          setUpMockHttpClientFaliure404();
      //act
      final call = await dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });


  group('getRandomNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
            () async {
          //arrange
          setUpMockHttpClientSuccess200();
          //act
          dataSource.getRandomNumberTrivia();
          //assert
          verify(mockHttpClient.get(
            Uri(scheme: 'http://numbersapi.com/random'),
            headers: {'Content-Type': 'application/json'},
          ));
        });

    test('should return NumberTrivia when the response cod is 200 (success)',
            () async {
          //arrange
          setUpMockHttpClientSuccess200();
          //act
          final result = await dataSource.getRandomNumberTrivia();
          //assert
          expect(result, equals(tNumberTriviaModel));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          //arrange
          setUpMockHttpClientFaliure404();
          //act
          final call = await dataSource.getRandomNumberTrivia;
          //assert
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        });
  });


}
