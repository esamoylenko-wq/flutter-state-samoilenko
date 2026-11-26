import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../widgets/history_badge.dart';
import 'history_screen.dart';

class CounterScreen extends StatefulWidget {
  final int counter;
  final List<HistoryEntry> history;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final VoidCallback onReset;
  final VoidCallback onClearHistory;

  const CounterScreen({
    super.key,
    required this.counter,
    required this.history,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    required this.onClearHistory,
  });

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _selectedStep = 1;

  void _handleDecrement() {
    if (widget.counter - _selectedStep < 0) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Значення лічильника не може бути відʼємним!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onDecrement(_selectedStep);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник (Етап 1)'),
        actions: [
          HistoryBadge(
            count: widget.history.length,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HistoryScreen(
                    history: widget.history,
                    onClearHistory: widget.onClearHistory,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Поточне значення:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              '${widget.counter}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            const Text('Оберіть крок зміни:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('1')),
                ButtonSegment(value: 5, label: Text('5')),
                ButtonSegment(value: 10, label: Text('10')),
              ],
              selected: {_selectedStep},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedStep = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonalIcon(
                  onPressed: _handleDecrement,
                  icon: const Icon(Icons.remove),
                  label: Text('-$_selectedStep'),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => widget.onIncrement(_selectedStep),
                  icon: const Icon(Icons.add),
                  label: Text('+$_selectedStep'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: widget.counter == 0 ? null : widget.onReset,
              icon: const Icon(Icons.refresh),
              label: const Text('Скинути'),
            ),
          ],
        ),
      ),
    );
  }
}