import 'package:flutter/material.dart';
import 'package:game_of_life/game_of_life_config.dart';
import 'package:game_of_life/universe.dart';
import 'package:game_of_life/universe_painter.dart';
import 'package:game_of_life/universe_ticker.dart';

class GameOfLife extends StatefulWidget {
  final GameOfLifeConfig config;

  const GameOfLife(this.config);

  @override
  _GameOfLifeState createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  UniverseTicker _notifier;
  Universe _universe;

  @override
  void initState() {
    super.initState();

    _universe = Universe(widget.config.gridHeight, widget.config.gridWidth);
    _notifier = UniverseTicker(_universe, widget.config);
  }

  @override
  void dispose() {
    _notifier?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UniversePainter(
          config: widget.config, universe: _universe, notifier: _notifier),
    );
  }
}
