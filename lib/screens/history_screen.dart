import 'package:material_ui/material_ui.dart';
import '../state/counter_state.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    final state = CounterScope.of(context);
    final history = state.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: [
          const HistoryBadge(),
          if (history.isNotEmpty)
            IconButton(
              onPressed: () {
                state.clearHistory();
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