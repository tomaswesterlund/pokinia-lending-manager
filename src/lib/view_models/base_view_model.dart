import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';

class BaseViewModel extends ChangeNotifier {
  States _state = States.ready;
  States get state => _state;
  set state(States state) {
    _state = state;
    notifyListeners();
  }

  bool get hasError => _state == States.error;
  bool get isInitializing => _state == States.initializing;
  bool get isLoading => _state == States.loading;
  bool get isProcessing => _state == States.processing;
  bool get isReady => _state == States.ready;
}
