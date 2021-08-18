import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class MealContentColumn extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/images/mealPage/' + imageName),
                ),
                Text(
                  mealName,
                  style: TextStyle(
                    fontSize: SizeConfig.sizeByHeight(16.0),
                  ),
                ),
              ],
            ),
            Text(
              mealTime,
              style: TextStyle(
                fontSize: SizeConfig.sizeByHeight(12.0),
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xffE0E0E0),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(98.0),
                    child: Text(
                      mealMenu[0],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(100.0),
                    child: Text(
                      mealMenu[1],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(98.0),
                    child: Text(
                      mealMenu[2],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(100.0),
                    child: Text(
                      mealMenu[3],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(98.0),
                    child: Text(
                      mealMenu[4],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(100.0),
                    child: Text(
                      mealMenu[5],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(98.0),
                    child: Text(
                      mealMenu[6],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(100.0),
                    child: Text(
                      mealMenu[7],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(16.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}