import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/game_objects/stocking/stocking_data.dart';
import 'package:stocking_sets/providers/game_logic.dart';

class Stocking extends StatefulWidget {
  const Stocking({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<Stocking> createState() => _StockingState();
}

class _StockingState extends State<Stocking> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Center(
          child: GestureDetector(
            onTap: () {
              context.read<GameLogic>().shuffleStockingColors(id: widget.id);
            },
            onTapDown: (details) {
              setState(() {
                isSelected = true;
              });
            },
            onTapUp: (details) {
              setState(() {
                isSelected = false;
              });
            },
            onTapCancel: () {
              setState(() {
                isSelected = false;
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 50),
                scale: isSelected ? 1.1 : 1.0,
                child: Draggable<StockingItem>(
                  data: context.watch<GameLogic>().stockingItems[widget.id],
                  feedback: StockingData(id: widget.id),
                  childWhenDragging: Container(),
                  child: StockingData(id: widget.id),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
