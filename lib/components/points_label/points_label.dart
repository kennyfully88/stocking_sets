import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/providers/game_logic.dart';

class PointsLabel extends StatelessWidget {
  const PointsLabel({super.key});

  @override
  Widget build(BuildContext context) {
    int points = context.watch<GameLogic>().points;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Points: $points',
        style: const TextStyle(
          fontSize: 32.0,
        ),
      ),
    );
  }
}
