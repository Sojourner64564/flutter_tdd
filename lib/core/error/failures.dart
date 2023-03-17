import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  Failure(this.properties =  const [],);

  final List<dynamic> properties;

  @override
  get props => properties;
}

//TODO: и так далее, делаешь реализации ошибок которые тебе нужны

class ServerFailure extends Failure {
  ServerFailure(this.statusCode =  0, this.message = "",) : super(properties: [statusCode, messageCode,],);
  final int statusCode;
  final String message;

}
