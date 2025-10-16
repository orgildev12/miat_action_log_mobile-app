import 'dart:async';
import 'package:flutter/material.dart';

class IdleManager {
  final Duration idleDuration;
  VoidCallback onTimeout;
  Timer? _timer;
  bool _enabled = false;

  IdleManager({
    required this.onTimeout,
    this.idleDuration = const Duration(minutes: 10),
  });

  void start() {
    if (_enabled) _resetTimer();
  }

  void enable() {
    _enabled = true;
    print('timer enabled');
    _resetTimer();
  }

  void disable() {
    _enabled = false;
    print('timer disabled');
    _timer?.cancel();
  }

  void _resetTimer() {
    if (!_enabled) return;
    _timer?.cancel();
    _timer = Timer(idleDuration, onTimeout);
  }
  
  bool isTimerEnabled(){
    return _enabled;
  }

  void userActivityDetected() {
    if (_enabled){
      _resetTimer();
      print('timer reseted');
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
