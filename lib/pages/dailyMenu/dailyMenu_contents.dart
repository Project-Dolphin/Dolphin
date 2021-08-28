import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';

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

class _MealContentColumn extends State<MealContentColumn>{
  @override
  void initState(){
    super.initState();
    mealParse();
    mariDormParse();
  }

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
                  image: AssetImage('assets/images/mealPage/' + widget.imageName),
                ),
                Text(
                  widget.mealName,
                  style: TextStyle(
                    fontSize: SizeConfig.sizeByHeight(16.0),
                  ),
                ),
              ],
            ),
            Text(
              widget.mealTime,
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
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[0],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[1],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
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
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[2],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[3],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
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
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[4],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[5],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
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
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[6],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[7],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.mealMenu.length > 9 ? Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[8],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[9],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ): Container(),
            widget.mealMenu.length > 11 ? Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.sizeByWidth(5.0),),
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[10],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.sizeByWidth(110.0),
                    child: Text(
                      widget.mealMenu[11],
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByHeight(15.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ): Container(),
          ],
        ),
      ],
    );
  }
}