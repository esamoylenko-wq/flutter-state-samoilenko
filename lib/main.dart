import 'package:flutter/material.dart';
import 'models/history_entry.dart';
import 'screens/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  final List<HistoryEntry> _history = [];

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

  void _increment(int step) {
    setState(() {
      final prev = _counter;
      _counter += step;
      _addHistory('Додано +$step', prev, _counter);
    });
  }

  void _decrement(int step) {
    if (_counter - step < 0) return;
    setState(() {
      final prev = _counter;
      _counter -= step;
      _addHistory('Віднято -$step', prev, _counter);
    });
  }

  void _reset() {
    if (_counter == 0) return;
    setState(() {
      final prev = _counter;
      _counter = 0;
      _addHistory('Скидання', prev, 0);
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: MyApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лічильник з історією',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: CounterScreen(
        counter: _counter,
        history: List.unmodifiable(_history),
        onIncrement: _increment,
        onDecrement: _decrement,
        onReset: _reset,
        onClearHistory: _clearHistory,
      ),
    );
  }
}