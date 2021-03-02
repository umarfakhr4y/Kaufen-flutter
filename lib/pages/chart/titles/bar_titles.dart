import '../data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarTitles {
  static SideTitles getTopTitles() => SideTitles(
      showTitles: true,
      reservedSize: 50,
      getTextStyles: (value) =>
          const TextStyle(color: Colors.grey, fontSize: 10),
      margin: 10,
      getTitles: (String) => "");

  static SideTitles getBottomTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (value) =>
            const TextStyle(color: Colors.grey, fontSize: 10),
        margin: 10,
        getTitles: (double id) => BarData.barData
            .firstWhere((element) => element.id == id.toInt())
            .name,
      );

  static SideTitles getRightTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (value) =>
            const TextStyle(color: Colors.grey, fontSize: 10),
        rotateAngle: 90,
        interval: BarData.interval.toDouble(),
        margin: 10,
        reservedSize: 30,
        getTitles: (String) => ""
      );

  static SideTitles getLeftTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (value) =>
            const TextStyle(color: Colors.grey, fontSize: 10),
        rotateAngle: 90,
        interval: BarData.interval.toDouble(),
        margin: 10,
        reservedSize: 30,
        getTitles: (double value) => value == 0 ? '0' : '${value.toInt()}k',
      );
}
