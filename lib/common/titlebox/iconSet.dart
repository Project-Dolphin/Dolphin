import 'package:flutter/material.dart';

class IconSet extends StatelessWidget {
  const IconSet({
    @required this.iconColor,
  });

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFFFFFF),
                shape: CircleBorder(),
                padding: EdgeInsets.all(8.5),
              ),
              child: Icon(
                Icons.search,
                size: 27.5,
                color: iconColor,
              ),
              onPressed: () {},
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFFFFFF),
                shape: CircleBorder(),
                padding: EdgeInsets.all(8.5),
              ),
              child: Icon(
                Icons.notifications_none,
                size: 27.5,
                color: iconColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
