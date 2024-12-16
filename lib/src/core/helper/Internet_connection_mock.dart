import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionMock implements InternetConnection {
  @override
  Duration get checkInterval => const Duration(seconds: 1);

  bool _hasInternetAccess = true;

  final StreamController<InternetStatus> _statusController =
      StreamController<InternetStatus>.broadcast();

  @override
  Future<bool> get hasInternetAccess async => _hasInternetAccess;

  @override
  Future<InternetStatus> get internetStatus async => _hasInternetAccess
      ? InternetStatus.connected
      : InternetStatus.disconnected;

  InternetStatus? _lastTryResults;

  @override
  InternetStatus? get lastTryResults => _lastTryResults;

  @override
  Stream<InternetStatus> get onStatusChange => _statusController.stream;

  void setConnectionStatus(bool isConnected) {
    _hasInternetAccess = isConnected;
    final newStatus =
        isConnected ? InternetStatus.connected : InternetStatus.disconnected;
    _lastTryResults = newStatus;
    _statusController.add(newStatus);
  }

  void dispose() {
    _statusController.close();
  }
}
