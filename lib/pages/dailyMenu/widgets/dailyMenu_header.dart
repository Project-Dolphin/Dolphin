import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';

class MyAppSpace extends StatelessWidget {
  const MyAppSpace(this.controller, {Key? key}) : super(key: key);

  final DailyMenuController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = Interval(fadeStart, fadeEnd).transform(t);
        Future.delayed(Duration.zero, () async {
          if (opacity > 0.5 && controller.isMoreButtonVisible) {
            controller.setIsMoreButtonVisible(false);
          } else if (opacity <= 0.5 && !controller.isMoreButtonVisible) {
            controller.setIsMoreButtonVisible(true);
          }
        });

        return Opacity(
          opacity: opacity,
          child: Container(
            color: Colors.white.withOpacity(0.4),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: SafeArea(
                bottom: false,
                left: false,
                right: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '식단',
                        style: TextStyle(
                            color: Color(0xFF353B45),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
