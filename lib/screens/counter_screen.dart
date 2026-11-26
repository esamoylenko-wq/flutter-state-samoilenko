import 'package:material_ui/material_ui.dart';
import '../state/counter_state.dart';
import '../widgets/history_badge.dart';
import 'history_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _selectedStep = 1;

  void _handleDecrement(CounterState state) {
    if (state.counter - _selectedStep < 0) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Значення лічильника не може бути відʼємним!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    state.decrement(_selectedStep);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');
    final state = CounterScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник (Етап 2)'),
        actions: [
          HistoryBadge(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
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
            const _CounterValueText(),
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
                  onPressed: () => _handleDecrement(state),
                  icon: const Icon(Icons.remove),
                  label: Text('-$_selectedStep'),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => state.increment(_selectedStep),
                  icon: const Icon(Icons.add),
                  label: Text('+$_selectedStep'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _ResetButton(),
          ],
        ),
      ),
    );
  }
}

class _CounterValueText extends StatelessWidget {
  const _CounterValueText();

  @override
  Widget build(BuildContext context) {
    debugPrint('build: _CounterValueText');
    final counter = CounterScope.of(context).counter;
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton();

  @override
  Widget build(BuildContext context) {
    final state = CounterScope.of(context);
    return OutlinedButton.icon(
      onPressed: state.counter == 0 ? null : state.reset,
      icon: const Icon(Icons.refresh),
      label: const Text('Скинути'),
    );
  }
}