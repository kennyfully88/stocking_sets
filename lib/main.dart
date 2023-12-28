import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/layouts/game_layout/game_layout.dart';
import 'package:stocking_sets/providers/game_logic.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GameLogic>(create: (_) => GameLogic()),
    ],
    child: const StockingSets(),
  ));
}

class StockingSets extends StatelessWidget {
  const StockingSets({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
        ),
        child: Container(
          color: const Color(0xFF004871),
          child: SafeArea(
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (BuildContext context) {
                    return const GameLayout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
