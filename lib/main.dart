import 'package:material_ui/material_ui.dart';
import 'screens/counter_screen.dart';
import 'state/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterState _counterState = CounterState();

  @override
  void dispose() {
    _counterState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: MyApp');
    return CounterScope(
      notifier: _counterState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Лічильник з історією',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const CounterScreen(),
      ),
    );
  }
}