import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class MealContentColumn extends StatefulWidget {
  const MealContentColumn({
    Key? key,
    @required this.mealName,
    @required this.mealTime,
    @required this.mealMenu,
    @required this.imageName,
  }) : super(key: key);

  final mealName;
  final mealTime;
  final mealMenu;
  final imageName;

  @override
  _MealContentColumn createState() => _MealContentColumn();
}

class _MealContentColumn extends State<MealContentColumn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var parsedMeal = parseMeal(widget.mealMenu);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image(
                    width: SizeConfig.sizeByHeight(30.0),
                    image: AssetImage(
                        'assets/images/mealPage/' + widget.imageName)),
                Text(widget.mealName, style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Text(widget.mealTime, style: TextStyle(fontSize: 12.0)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.sizeByHeight(5.0),
          ),
          child: Image(
            height: SizeConfig.blockSizeHorizontal,
            image: AssetImage('assets/images/mealPage/divider.png'),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...parsedMeal.map((e) => Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var i in e)
                      Container(
                        height: SizeConfig.sizeByHeight(20),
                        width: SizeConfig.sizeByWidth(360),
                        margin: EdgeInsets.only(
                          top: SizeConfig.sizeByHeight(13),
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                  ],
                ))),
          ],
        ),
      ],
    );
  }

  parseMeal(List<String> mealData) {
    var len = mealData.length;
    var size = 5;
    var chunks = [];

    for (var i = 0; i < len; i += size) {
      var end = (i + size < len) ? i + size : len;
      chunks.add(mealData.sublist(i, end));
    }
    return chunks;
  }
}
