import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stocking_sets/providers/game_logic.dart';

class MatchingStockingData extends StatefulWidget {
  const MatchingStockingData({super.key, required this.id});

  final int id;

  @override
  State<MatchingStockingData> createState() => _MatchingStockingDataState();
}

class _MatchingStockingDataState extends State<MatchingStockingData> {
  @override
  Widget build(BuildContext context) {
    StockingItem matchingStocking =
        context.watch<GameLogic>().matchingStockingItems[widget.id];

    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const RadialGradient(
                center: Alignment(-0.00, 0.2),
                radius: 0.3,
                stops: <double>[
                  0.3,
                  1.0,
                ],
                colors: <Color>[
                  Color(0x00FFFFFF),
                  Color(0x80000000),
                ],
                tileMode: TileMode.clamp,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: SvgPicture.asset(
              'images/stocking_l1.svg',
              colorFilter: ColorFilter.mode(
                matchingStocking.colorL1.color,
                BlendMode.srcIn,
              ),
            ),
          ),
          Stack(
            children: [
              Transform.translate(
                offset: const Offset(0.0, -1),
                child: SvgPicture.asset(
                  'images/stocking_l2.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFFFFFF),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(2.5, 2.5),
                child: SvgPicture.asset(
                  'images/stocking_l2.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0x80000000),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SvgPicture.asset(
                'images/stocking_l2.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFF00),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const RadialGradient(
                center: Alignment.topCenter,
                radius: 0.5,
                stops: <double>[
                  0.6,
                  0.9,
                ],
                colors: <Color>[
                  Color(0x00FFFFFF),
                  Color(0x80000000),
                ],
                tileMode: TileMode.repeated,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: SvgPicture.asset(
              'images/stocking_l3.svg',
              colorFilter: ColorFilter.mode(
                matchingStocking.colorL3.color,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
