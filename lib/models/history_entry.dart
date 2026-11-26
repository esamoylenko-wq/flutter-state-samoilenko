class HistoryEntry {
  final DateTime timestamp;
  final String action;
  final int previousValue;
  final int newValue;

  const HistoryEntry({
    required this.timestamp,
    required this.action,
    required this.previousValue,
    required this.newValue,
  });

  String get formattedTime {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    final seconds = timestamp.second.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}