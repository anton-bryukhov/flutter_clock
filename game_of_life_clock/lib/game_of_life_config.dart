import 'package:flutter/material.dart';

class GameOfLifeConfig {
  /// Number of cells in each column
  final int gridHeight;

  /// Number of cells in each row
  final int gridWidth;

  /// Gap between pixels in different rows and columns in pixels
  final int cellGap;

  /// How frequently cells will update
  final Duration updateRate;

  /// Gradient used for cell paint shader
  final Gradient gradient;

  /// Reset cells after this number of ticks with same number of alive cells
  final int maxTicksWithSameAliveCount;

  /// Reset cells after this number of ticks without reset
  final int maxTicksWithoutReset;

  const GameOfLifeConfig({
    @required this.gridHeight,
    @required this.gridWidth,
    @required this.gradient,
    @required this.cellGap,
    @required this.updateRate,
    @required this.maxTicksWithSameAliveCount,
    @required this.maxTicksWithoutReset,
  });
}
