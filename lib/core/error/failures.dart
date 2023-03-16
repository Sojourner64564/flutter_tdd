import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  Failure([
    List properties = const<dynamic>[]]);

  final List<dynamic> properties=[];

  @override
  get props => properties;
}