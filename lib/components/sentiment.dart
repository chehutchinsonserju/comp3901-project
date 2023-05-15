// ignore_for_file: prefer_const_constructors

import 'package:capstone/components/sentiment_value_notifier.dart';
import 'package:flutter/material.dart';

class MoodTracker extends StatefulWidget {
  final double sentimentScore;
  const MoodTracker({super.key, required this.sentimentScore});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  late String _moodText = '';
  late SentimentScoreNotifier sentimentScoreNotifier;

  @override
  void initState() {
    super.initState();
    sentimentScoreNotifier = SentimentScoreNotifier(
        value: SentimentScore(sentimentScore: ValueNotifier<double>(0)));
  }

  @override
  void dispose() {
    super.dispose();
    sentimentScoreNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _moodText = widget.sentimentScore >= 0.3
        ? 'Good Mood'
        : widget.sentimentScore < 0.3 && widget.sentimentScore >= 0
            ? 'Neutral Mood'
            : 'Bad Mood';
    return Card(
      child: ValueListenableBuilder(
          valueListenable: sentimentScoreNotifier.value.sentimentScore.value,
          builder: (BuildContext context, int value, Widget? child) {
            return ListTile(
                title: Text('You seem to be in a...'),
                subtitle: Text(_moodText));
          }),
    );
  }
}
