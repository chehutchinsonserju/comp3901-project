import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodChart extends StatelessWidget {
  const MoodChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(minX: 0, maxX: 6, minY: -1, maxY: 1, lineBarsData: [
      LineChartBarData(spots: [
        FlSpot(0, 1),
        FlSpot(1, 0.5),
        FlSpot(2, 0.3),
        FlSpot(3, -0.4),
        FlSpot(4, -0.9),
        FlSpot(5, -1),
        FlSpot(6, 0.2),
      ])
    ]));
  }
}
