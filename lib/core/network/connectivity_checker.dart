import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityChecker {
  Future<bool> get isConnected;
}

class ConnectivityCheckerImpl implements ConnectivityChecker {
  @override
  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    // The connectivity package now returns a List<ConnectivityResult>
    return !result.contains(ConnectivityResult.none);
  }
}