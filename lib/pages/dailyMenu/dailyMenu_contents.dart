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
    //print('widget.mealMenu : ${widget.mealMenu}');
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
                  image:
                      AssetImage('assets/images/mealPage/' + widget.imageName),
                ),
                Text(
                  widget.mealName,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Text(
              widget.mealTime,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
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
        Column(
          children: [
            ...widget.mealMenu.map(
              (e) => Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.sizeByWidth(5.0),
                ),
                width: SizeConfig.sizeByWidth(110.0),
                child: Text(
                  '$e',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
