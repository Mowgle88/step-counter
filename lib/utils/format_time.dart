String formatTime(Duration? dur) {
  if (dur == null) return '0:00:00';
  String seconds = (dur.inSeconds % 60).toString().padLeft(2, '0');
  String minutes = (dur.inMinutes % 60).toString().padLeft(2, '0');
  String hours = dur.inHours.toString();
  return "$hours:$minutes:$seconds";
}
