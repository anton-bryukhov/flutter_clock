import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:game_of_life_clock/game_of_life_config.dart';
import 'package:game_of_life_clock/root.dart';

const config = GameOfLifeConfig(
  gridHeight: 16,
  gridWidth: 27,
  gradient: LinearGradient(colors: [
    Color(0xff77A1D3),
    Color(0xff79CBCA),
    Color(0xffE684AE),
  ]),
  updateRate: Duration(milliseconds: 125),
  cellGap: 3,
  maxTicksWithSameAliveCount: 4,
  maxTicksWithoutReset: 800,
);

void main() => runApp(ClockCustomizer((model) => Root(model, config)));
