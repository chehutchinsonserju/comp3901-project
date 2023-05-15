import 'package:flutter/material.dart';

class SentimentScore {
  ValueNotifier<double> sentimentScore = ValueNotifier<double>(0);

  SentimentScore({required this.sentimentScore});
}

class SentimentScoreNotifier extends ValueNotifier {
  SentimentScoreNotifier({required SentimentScore value}) : super(value);

  void updateSentimentScore(double sentimentScore) {
    value.sentimentScore.value = sentimentScore;
    notifyListeners();
  }
}
