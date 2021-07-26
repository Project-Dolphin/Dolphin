import 'package:flutter/material.dart';
import 'package:getx_app/common/sizeConfig.dart';

class IconSet extends StatelessWidget {
  const IconSet({
    @required this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByHeight(19)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFFFFF),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                ),
                child: Icon(
                  Icons.search,
                  size: SizeConfig.sizeByHeight(27.5),
                  color: iconColor,
                ),
                onPressed: () {},
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFFFFF),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                ),
                child: Icon(
                  Icons.notifications_none,
                  size: SizeConfig.sizeByHeight(27.5),
                  color: iconColor,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
