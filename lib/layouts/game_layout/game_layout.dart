import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/components/points_label/points_label.dart';
import 'package:stocking_sets/components/time_bar/time_bar.dart';
import 'package:stocking_sets/game_objects/matching_stocking/matching_stocking.dart';
import 'package:stocking_sets/game_objects/stocking/stocking.dart';
import 'package:stocking_sets/providers/game_logic.dart';

class GameLayout extends StatefulWidget {
  const GameLayout({super.key});

  @override
  State<GameLayout> createState() => _GameLayoutState();
}

class _GameLayoutState extends State<GameLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool isSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );

    _animationController.addListener(() {
      if (_animationController.value == 1) {
        context.read<GameLogic>().setActiveGame(isActive: false);
      }

      setState(() {});
    });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool midOrMoreSize = MediaQuery.sizeOf(context).width > 768;

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (midOrMoreSize)
              Row(
                children: [
                  const Expanded(child: PointsLabel()),
                  Expanded(
                    child: TimeBar(
                      animationValue: _animationController.value,
                    ),
                  ),
                ],
              ),
            if (!midOrMoreSize)
              TimeBar(animationValue: _animationController.value),
            if (!midOrMoreSize) const PointsLabel(),
            Expanded(
              child: midOrMoreSize
                  ? Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (int i = 0; i < 3; i++) Stocking(id: i),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              for (int i = 0; i < 2; i++)
                                MatchingStocking(id: i),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              for (int i = 0; i < 2; i++)
                                MatchingStocking(id: i),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (int i = 0; i < 3; i++) Stocking(id: i),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
        if (!context.watch<GameLogic>().activeGame)
          Container(
            color: const Color(0x80000000),
            child: Center(
              child: Container(
                color: const Color(0xFF202020),
                width: 256,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(fontSize: 32.0),
                    ),
                    Text(
                      'Score: ${context.watch<GameLogic>().points}',
                      style: const TextStyle(fontSize: 28.0),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (details) {
                        setState(() {
                          isSelected = true;
                        });
                      },
                      onExit: (details) {
                        setState(() {
                          isSelected = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          context.read<GameLogic>().resetGame();
                          _animationController.value = 0;
                          _animationController.forward();
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
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 50),
                          scale: isSelected ? 1.1 : 1.0,
                          child: Container(
                            color: isSelected
                                ? const Color(0x80FFFFFF)
                                : const Color(0xFFFFFFFF),
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            child: const Text(
                              'New Game',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
