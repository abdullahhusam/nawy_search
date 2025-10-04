import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  ConnectivityService() {
    // Listen for changes
    _connectivity.onConnectivityChanged.listen((results) {
      final hasConnection = results.any(
        (r) => r == ConnectivityResult.mobile || r == ConnectivityResult.wifi,
      );
      _controller.add(hasConnection);
    });

    // Check initial state
    _connectivity.checkConnectivity().then((results) {
      final hasConnection = results.any(
        (r) => r == ConnectivityResult.mobile || r == ConnectivityResult.wifi,
      );
      _controller.add(hasConnection);
    });
  }

  Stream<bool> get connectivityStream => _controller.stream;

  void dispose() => _controller.close();
}
