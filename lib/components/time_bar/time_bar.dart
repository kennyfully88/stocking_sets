import 'package:flutter/widgets.dart';

class TimeBar extends StatefulWidget {
  const TimeBar({
    super.key,
    required this.animationValue,
  });

  final double animationValue;

  @override
  State<TimeBar> createState() => _TimeBarState();
}

class _TimeBarState extends State<TimeBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Time:',
            style: TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                color: const Color(0xFF000000),
                height: 48.0,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(50.0)),
                        width: constraints.maxWidth -
                            (widget.animationValue * constraints.maxWidth),
                        height: 48.0,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
