import 'package:flutter/widgets.dart';
import '../models/history_entry.dart';

class CounterState extends ChangeNotifier {
  int _counter = 0;
  final List<HistoryEntry> _history = [];

  int get counter => _counter;
  List<HistoryEntry> get history => List.unmodifiable(_history);

  void _addHistory(String action, int prev, int next) {
    _history.insert(
      0,
      HistoryEntry(
        timestamp: DateTime.now(),
        action: action,
        previousValue: prev,
        newValue: next,
      ),
    );
  }

  void increment(int step) {
    final prev = _counter;
    _counter += step;
    _addHistory('Додано +$step', prev, _counter);
    notifyListeners();
  }

  void decrement(int step) {
    if (_counter - step < 0) return;
    final prev = _counter;
    _counter -= step;
    _addHistory('Віднято -$step', prev, _counter);
    notifyListeners();
  }

  void reset() {
    if (_counter == 0) return;
    final prev = _counter;
    _counter = 0;
    _addHistory('Скидання', prev, 0);
    notifyListeners();
  }

  void clearHistory() {
    if (_history.isEmpty) return;
    _history.clear();
    notifyListeners();
  }
}

class CounterScope extends InheritedNotifier<CounterState> {
  const CounterScope({
    super.key,
    required CounterState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static CounterState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CounterScope>();
    assert(scope != null, 'CounterScope не знайдено в дереві віджетів');
    return scope!.notifier!;
  }
}