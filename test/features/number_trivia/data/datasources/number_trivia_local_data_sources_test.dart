import 'dart:convert';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixtures_reader.dart';


class MockSharedPreferences extends Mock implements SharedPreferences {

}


void main(){
  NumberTriviaLocalDataSourcesImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  mockSharedPreferences = MockSharedPreferences();
  dataSource = NumberTriviaLocalDataSourcesImpl(sharedPreferences: mockSharedPreferences);

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test('should return NumberTrivia from SharedPreferences when there is one in the cached ', () async {
      //arrange
      when(mockSharedPreferences.getString(any as String)).thenReturn(fixture('trivia_cached.json'));
      //act
      final result = await dataSource.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cache value', () async {
      //arrange
      when(mockSharedPreferences.getString(any as String)).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;
      //assert
      expect(()=> call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cachedNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test trivia');

    test('sould call SharedPreferences to cache the data', () async {
      //act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      //assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
    });

  });

}