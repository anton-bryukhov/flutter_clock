import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_of_life/game_of_life_config.dart';
import 'package:game_of_life/universe.dart';

class UniverseTicker with ChangeNotifier {
  final Universe _universe;
  final GameOfLifeConfig _config;

  Timer _timer;

  UniverseTicker(this._universe, this._config) {
    _timer = Timer.periodic(_config.updateRate, _tick);
  }

  void _tick(_) {
    if (_universe.ticksSinceLastReset >= _config.maxTicksWithoutReset ||
        _universe.ticksWithSameAliveCount >=
            _config.maxTicksWithSameAliveCount) {
      _universe.reset();
    } else {
      _universe.tick();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }
}
