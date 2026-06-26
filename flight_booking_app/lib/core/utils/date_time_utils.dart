extension DateTimeExtension on DateTime {
  String get hhmm =>
      '${hour.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')}';

  String get formatDate {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[month]}, '
        '${day.toString().padLeft(2, '0')} '
        '$year';
  }
}

extension DurationExtension on int {
  String get durationText =>
      '${this ~/ 60}h ${(this % 60).toString().padLeft(2, '0')}m';
}
