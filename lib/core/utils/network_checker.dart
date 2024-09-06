import 'dart:async';
import 'package:connectivity/connectivity.dart';

class NetworkChecker {
  final Connectivity _connectivity = Connectivity();

  final StreamController<bool> _networkStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get networkStatusStream => _networkStatusController.stream;

  NetworkChecker() {
    _initialize();
  }

  Future<void> _initialize() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateNetworkStatus(result);

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateNetworkStatus(result);
    });
  }

  void _updateNetworkStatus(ConnectivityResult result) {
    bool isOnline = result != ConnectivityResult.none;
    _networkStatusController.add(isOnline);
  }

  Future<bool> isOnline() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _networkStatusController.close();
  }
}
