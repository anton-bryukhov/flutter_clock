import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Clock extends StatefulWidget {
  const Clock(this.model);

  final ClockModel model;

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  static final _format24Hour = DateFormat.Hm();
  static final _format12Hour = DateFormat.jm();

  DateTime _dateTime = DateTime.now();
  DateFormat _dateFormat;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);

    _updateModel();
    _updateTime();
  }

  @override
  void didUpdateWidget(Clock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() => setState(() {
        _dateFormat =
            widget.model.is24HourFormat ? _format24Hour : _format12Hour;
      });

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = _dateFormat.format(_dateTime);

    return Text(
      time,
      style: Theme.of(context).textTheme.display4,
    );
  }
}
