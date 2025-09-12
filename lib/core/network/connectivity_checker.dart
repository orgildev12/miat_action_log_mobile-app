import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityChecker {
  Future<bool> get isConnected;
}

class ConnectivityCheckerImpl implements ConnectivityChecker {
  @override
  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}