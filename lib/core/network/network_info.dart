//import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  //final DataConnectionChecker connectionChecker;

//   bool cringe = true;

  @override
  Future<bool> get isConnected => cringe; //connectionChecker.hasConnection

}


Future<bool> get cringe async {
  return true;

}