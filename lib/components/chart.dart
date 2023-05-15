import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


User? _user;

class MoodChart extends StatelessWidget {
  const MoodChart({super.key});


  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    interval: 1,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = '1';
          break;
        case 1:
          text = '2';
          break;
        case 2:
          text = '3';
          break;
        case 3:
          text = '4';
          break;
        case 4:
          text = '5';
          break;
        case 5:
          text = '6';
          break;
        case 6:
          text = '7';
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
          text = 'Negative Mood';
          break;
        case 0:
          text = 'Neutral';
          break;
        case 1:
          text = 'Positive Mood';
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

    _user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<QuerySnapshot>(
        future:  FirebaseFirestore.instance.collection('response').orderBy('timestamp', descending: true).get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }

    // Convert Firestore data to a list of FlSpot objects
    final data = snapshot.data?.docs.fold<List<FlSpot>>([], (list, doc) {
      if (doc['client_id'] == _user?.uid) {
        list.add(FlSpot(list.length.toDouble(), doc['sentimentscore']));
      }
      return list;
    }).take(7).toList() ?? [];

    return AspectRatio(
      aspectRatio: 2,
      child: Center(
        child: LineChart(LineChartData(
          minX: 0,
          maxX: 6,
          minY: -1,
          maxY: 1,
          lineBarsData: [
            LineChartBarData(spots: data)
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
    },
    );
  }
}