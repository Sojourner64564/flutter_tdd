import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/core/error/failures.dart';
import 'package:flutter_tdd/core/network/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_nrivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  mockRemoteDataSource = MockRemoteDataSource();
  mockLocalDataSource = MockLocalDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = NumberTriviaRepositoryImpl(
    mockRemoteDataSource,
    mockLocalDataSource,
    mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  final tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel(number: tNumber, text: "test trivia");
  final NumberTrivia tNumberTrivia = tNumberTriviaModel;

  group('getConcreteNumberTrivia', () {
    test(
      "should check if the device is online",
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  });

  runTestsOnline( () {
    test(
      "should remote data when the call to remote data source is successful",
      () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      },
    );

    test(
      "should cach the data localy when the call to remote data source is successful",
      () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      },
    );

    test(
      "should server failure when the call to remote data source is unsuccessful",
      () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  runTestsOffline( () {

    test(
      "should return last locally data when data the cached data is present",
      () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      },
    );

    test(
      "should return CacheFailure when there is no cached data present",
      () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });

  //---------------------------------


  final tNumberRandomTriviaModel =
  NumberTriviaModel(number: 123, text: "test trivia");


  group('getRandomNumberTrivia', () {
    test(
      "should check if the device is online",
          () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getRandomNumberTrivia();
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  });

  runTestsOnline( () {
    test(
      "should remote data when the call to remote data source is successful",
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberRandomTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      },
    );

    test(
      "should cach the data localy when the call to remote data source is successful",
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberRandomTriviaModel);
        //act
        await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberRandomTriviaModel));
      },
    );

    test(
      "should server failure when the call to remote data source is unsuccessful",
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  runTestsOffline( () {

    test(
      "should return last locally data when data the cached data is present",
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberRandomTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      },
    );

    test(
      "should return CacheFailure when there is no cached data present",
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });

}
