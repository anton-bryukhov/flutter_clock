import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:game_of_life_clock/clock.dart';
import 'package:game_of_life_clock/game_of_life_config.dart';
import 'package:game_of_life_clock/game_of_life.dart';

class Root extends StatelessWidget {
  const Root(this._model, this._config);

  final ClockModel _model;
  final GameOfLifeConfig _config;

  ThemeData _getThemeData(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final display4Style = textTheme.display4;

    return theme.copyWith(
      textTheme: textTheme.copyWith(
        display4: display4Style.copyWith(
          fontWeight: FontWeight.bold,
          color: display4Style.color
              .withOpacity(theme.brightness == Brightness.light ? 0.8 : 0.9),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: _getThemeData(context),
        child: Container(
          child: Stack(
            children: <Widget>[
              SizedBox.expand(child: GameOfLife(_config)),
              Center(child: Clock(_model)),
            ],
          ),
        ),
      );
}
