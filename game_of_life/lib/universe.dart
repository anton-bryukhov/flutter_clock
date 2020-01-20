import 'dart:math';
import 'dart:typed_data';

class Universe {
  static const _ALIVE = 1;
  static const _DEAD = 0;

  final Random _generator = Random();
  final int _width;
  final int _height;
  Uint8List _cells;

  int _aliveCount;
  int ticksSinceLastReset;
  int ticksWithSameAliveCount;

  Universe(int height, int width)
      : this._(height, width, Uint8List(height * width));

  Universe._(this._height, this._width, this._cells) {
    reset();
  }

  void reset() {
    _aliveCount = 0;
    ticksSinceLastReset = 0;
    ticksWithSameAliveCount = 0;

    for (int i = 0; i < _cells.length; ++i) {
      if (_generator.nextBool()) {
        _cells[i] = _ALIVE;
        _aliveCount += 1;
      } else {
        _cells[i] = _DEAD;
      }
    }

    tick();
  }

  void tick() {
    ticksSinceLastReset += 1;

    final next = Uint8List(_cells.length);
    var nextAliveCount = 0;

    for (var row = 0; row < _height; ++row) {
      for (var col = 0; col < _width; ++col) {
        final idx = _getCellIndexAt(row, col);
        final cell = _cells[idx];
        final liveNeighbors = _getLiveNeighborCountAt(row, col);
        final cellNextState = _getCellNextState(cell, liveNeighbors);

        next[idx] = cellNextState;
        if (cellNextState == _ALIVE) {
          nextAliveCount += 1;
        }
      }
    }

    _cells = next;

    if (_aliveCount == nextAliveCount) {
      ticksWithSameAliveCount += 1;
    } else {
      ticksWithSameAliveCount = 0;
      _aliveCount = nextAliveCount;
    }
  }

  bool isCellAliveAt(int row, int col) => _getCellAt(row, col) == _ALIVE;

  int _getCellAt(int row, int col) => _cells[_getCellIndexAt(row, col)];

  int _getCellNextState(int cellState, int liveNeighborCount) {
    if (cellState == _ALIVE) {
      if (liveNeighborCount == 2 || liveNeighborCount == 3) {
        return cellState;
      }

      return _DEAD;
    }

    if (liveNeighborCount == 3) {
      return _ALIVE;
    }

    return cellState;
  }

  int _getCellIndexAt(int row, int col) => row * _width + col;

  int _getLiveNeighborCountAt(int row, int col) {
    var count = 0;

    final north = row == 0 ? _height - 1 : row - 1;
    final south = row == _height - 1 ? 0 : row + 1;
    final west = col == 0 ? _width - 1 : col - 1;
    final east = col == _width - 1 ? 0 : col + 1;

    count += _getCellAt(north, west);
    count += _getCellAt(north, col);
    count += _getCellAt(north, east);
    count += _getCellAt(row, west);
    count += _getCellAt(row, east);
    count += _getCellAt(south, west);
    count += _getCellAt(south, col);
    count += _getCellAt(south, east);

    return count;
  }
}
