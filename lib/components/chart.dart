import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodChart extends StatelessWidget {
  const MoodChart({super.key});

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Sun';
              break;
            case 1:
              text = 'Mon';
              break;
            case 2:
              text = 'Tue';
              break;
            case 3:
              text = 'Wed';
              break;
            case 4:
              text = 'Thurs';
              break;
            case 5:
              text = 'Fri';
              break;
            case 6:
              text = 'Sat';
              break;
          }
          return Text(
            text,
            style: const TextStyle(fontSize: 12),
          );
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        interval: 1,
        reservedSize: 50,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case -1:
              text = 'Bad Mood';
              break;
            case 0:
              text = 'Neutral';
              break;
            case 1:
              text = 'Good Mood';
              break;
          }
          return Text(
            text,
            style: const TextStyle(fontSize: 12),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Center(
        child: LineChart(LineChartData(
          minX: 0,
          maxX: 6,
          minY: -1,
          maxY: 1,
          lineBarsData: [
            LineChartBarData(spots: [
              FlSpot(0, 1),
              FlSpot(1, 0.5),
              FlSpot(2, 0.3),
              FlSpot(3, -0.4),
              FlSpot(4, -0.9),
              FlSpot(5, -1),
              FlSpot(6, 0.2),
            ])
          ],
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: _leftTitles),
          ),
        )),
      ),
    );
  }
}
