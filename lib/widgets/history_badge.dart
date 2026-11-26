import 'package:material_ui/material_ui.dart';
import '../state/counter_state.dart';

class HistoryBadge extends StatelessWidget {
  final VoidCallback? onPressed;

  const HistoryBadge({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');
    final count = CounterScope.of(context).history.length;
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