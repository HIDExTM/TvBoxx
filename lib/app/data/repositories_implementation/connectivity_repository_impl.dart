import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart'; // Importar kIsWeb

import '../../domain/repositories/connectivity_repository.dart';
import '../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;
  final _controller = StreamController<bool>.broadcast();

  late bool _hasInternet;
  StreamSubscription? _subscription;
  bool _initialized = false;

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );

  @override
  Future<void> initialize() async {
    Future<bool> hasInternet(ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        return false;
      }
      return _internetChecker.hasInternet();
    }

    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    _hasInternet = await hasInternet(
        results.isNotEmpty ? results.first : ConnectivityResult.none);

    _initialized = true;

    _connectivity.onConnectivityChanged.skip(kIsWeb ? 0 : 1).listen(
      // Cambio aquí
      (event) async {
        _subscription?.cancel();
        _subscription =
            hasInternet(event as ConnectivityResult).asStream().listen(
          (value) {
            _hasInternet = value;

            if (_controller.hasListener && !_controller.isClosed) {
              _controller.add(_hasInternet);
            }
          },
        );
      },
    );
  }

  @override
  bool get hasInternet {
    assert(_initialized, 'initialize must be called first');
    return _hasInternet;
  }

  @override
  Stream<bool> get onInternetChanged => _controller.stream;
}
