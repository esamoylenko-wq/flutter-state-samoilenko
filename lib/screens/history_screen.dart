import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatelessWidget {
  final List<HistoryEntry> history;
  final VoidCallback onClearHistory;

  const HistoryScreen({
    super.key,
    required this.history,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: [
          HistoryBadge(
            count: history.length,
            onPressed: () {},
          ),
          if (history.isNotEmpty)
            IconButton(
              onPressed: () {
                onClearHistory();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Очистити історію',
            ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'Історія порожня',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${history.length - index}'),
                  ),
                  title: Text('${entry.action}: ${entry.previousValue} → ${entry.newValue}'),
                  subtitle: Text('Час: ${entry.formattedTime}'),
                );
              },
            ),
    );
  }
}