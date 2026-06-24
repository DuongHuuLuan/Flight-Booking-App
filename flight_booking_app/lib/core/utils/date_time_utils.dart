extension DateTimeExtension on DateTime {
  String get hhmm =>
      '${hour.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')}';
}

extension DurationExtension on int {
  String get durationText =>
      '${this ~/ 60}h ${(this % 60).toString().padLeft(2, '0')}m';
}
