class TimeDiference {
  static String calculateTimeDifferenceBetween(
      {required DateTime startDate, required DateTime endDate}) {
    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60) {
      return '$seconds segundos';
    } else if (seconds >= 60 && seconds < 3600) {
      return '${startDate.difference(endDate).inMinutes.abs()} minuto';
    } else if (seconds >= 3600 && seconds < 86400) {
      return '${startDate.difference(endDate).inHours} hora';
    } else {
      return '${startDate.difference(endDate).inDays} dia';
    }
  }
}
