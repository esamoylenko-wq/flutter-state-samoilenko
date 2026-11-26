import 'package:flutter/material.dart';

class HistoryBadge extends StatelessWidget {
  final int count;
  final VoidCallback onPressed;

  const HistoryBadge({
    super.key,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Історія змін',
      icon: Badge(
        label: Text('$count'),
        isLabelVisible: count > 0,
        child: const Icon(Icons.history),
      ),
    );
  }
}