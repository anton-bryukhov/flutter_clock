import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_of_life_clock/game_of_life_config.dart';
import 'package:game_of_life_clock/universe.dart';

class UniversePainter extends CustomPainter {
  final Universe universe;
  final GameOfLifeConfig config;

  bool _initialized = false;
  Paint _cellPaint;
  Size _cellSize;
  double _xOffset;
  double _yOffset;
  Radius _cellBorderRadius;

  UniversePainter({
    @required this.universe,
    @required this.config,
    @required notifier,
  }) : super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size canvasSize) {
    _initialize(canvasSize);
    _drawCells(canvas);
  }

  void _initialize(Size canvasSize) {
    if (_initialized) {
      return;
    }

    final cellDimen =
        min(_getCellXDimen(canvasSize), _getCellYDimen(canvasSize));
    _cellSize = Size(cellDimen, cellDimen);

    _xOffset = _getXOffset(canvasSize);
    _yOffset = _getYOffset(canvasSize);

    final gradientRect =
        const Offset(0, 0) & Size(canvasSize.width, canvasSize.height);
    _cellPaint = Paint()..shader = config.gradient.createShader(gradientRect);
    _cellBorderRadius = Radius.circular(_cellSize.height / 3);

    _initialized = true;
  }

  void _drawCells(Canvas canvas) {
    for (var row = 0; row < config.gridHeight; ++row) {
      for (var col = 0; col < config.gridWidth; ++col) {
        if (universe.isCellAliveAt(row, col)) {
          final cellOrigin = _getCellOriginAt(row, col);
          final cellRect = cellOrigin & _cellSize;

          drawCell(canvas, cellRect);
        }
      }
    }
  }

  void drawCell(Canvas canvas, Rect cellRect) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(cellRect, _cellBorderRadius),
      _cellPaint,
    );
  }

  Offset _getCellOriginAt(int row, int col) => Offset(
        col * (_cellSize.width + config.cellGap) + _xOffset,
        row * (_cellSize.height + config.cellGap) + _yOffset,
      );

  double _getCellXDimen(Size canvasSize) =>
      (canvasSize.width - (config.gridWidth - 1) * config.cellGap) /
      config.gridWidth;

  double _getCellYDimen(Size canvasSize) =>
      (canvasSize.height - (config.gridHeight - 1) * config.cellGap) /
      config.gridHeight;

  double _getXOffset(Size canvasSize) =>
      (canvasSize.width -
          config.gridWidth * _cellSize.width -
          (config.gridWidth - 1) * config.cellGap) /
      2;

  double _getYOffset(Size canvasSize) =>
      (canvasSize.height -
          config.gridHeight * _cellSize.width -
          (config.gridHeight - 1) * config.cellGap) /
      2;

  @override
  bool shouldRepaint(_) => true;
}
