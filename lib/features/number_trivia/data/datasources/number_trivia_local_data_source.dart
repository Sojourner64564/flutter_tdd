import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourcesImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourcesImpl({required this.flutterSecurityStorage});

  //final SharedPreferences sharedPreferences;
  final FlutterSecureStorage flutterSecurityStorage;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    //final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    final jsonString = flutterSecurityStorage.read(key: CACHED_NUMBER_TRIVIA);
    if(jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString as String)));
    } else{
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    //return sharedPreferences.setString(CACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
    return flutterSecurityStorage.write(key: CACHED_NUMBER_TRIVIA, value: json.encode(triviaToCache.toJson()));
  }

}