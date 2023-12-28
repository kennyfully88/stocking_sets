import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/game_objects/matching_stocking/matching_stocking_data.dart';
import 'package:stocking_sets/providers/game_logic.dart';

class MatchingStocking extends StatefulWidget {
  const MatchingStocking({super.key, required this.id});

  final int id;

  @override
  State<MatchingStocking> createState() => _MatchingStockingState();
}

class _MatchingStockingState extends State<MatchingStocking> {
  @override
  Widget build(BuildContext context) {
    StockingItem matchingStocking =
        context.watch<GameLogic>().matchingStockingItems[widget.id];

    return Expanded(
      child: SizedBox(
        width: 256,
        height: 256,
        child: Center(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: GestureDetector(
              onTap: () {
                context
                    .read<GameLogic>()
                    .shuffleMatchingStockingColors(id: widget.id);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: DragTarget<StockingItem>(
                  onWillAccept: (details) {
                    bool result = details?.colorL1.color ==
                            matchingStocking.colorL1.color &&
                        details?.colorL3.color ==
                            matchingStocking.colorL3.color;

                    return result;
                  },
                  onAccept: (details) {
                    context.read<GameLogic>().addPoints(stocking: details);

                    context
                        .read<GameLogic>()
                        .shuffleMatchingStockingColors(id: widget.id);

                    context
                        .read<GameLogic>()
                        .shuffleStockingColors(id: details.id);
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      color: rejectedData.isNotEmpty
                          ? const Color(0x80FF0000)
                          : candidateData.isNotEmpty
                              ? const Color(0x8000FF00)
                              : null,
                      child: MatchingStockingData(id: widget.id),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
