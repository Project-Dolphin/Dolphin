import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_app/common/sizeConfig.dart';

class OnelineTitle extends StatelessWidget {
  const OnelineTitle({
    Key key,
    @required this.name,
    @required this.description,
    @required this.stat,
    @required this.fontsize1,
    @required this.fontsize2,
    @required this.fontsize3,
    @required this.fontweight1,
    @required this.fontweight2,
    @required this.fontweight3,
  }) : super(key: key);

  final String name, description, stat;
  final double fontsize1, fontsize2, fontsize3;
  final FontWeight fontweight1, fontweight2, fontweight3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.sizeByWidth(24)),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MainTitle(
                title: name,
                fontsize: fontsize1,
                fontweight: fontweight1,
              ),
              SubText(
                description: description,
                fontsize: fontsize2,
                fontweight: fontweight2,
              ),
              StatusContainer(
                stat: stat,
                fontsize: fontsize3,
                fontweight: fontweight3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainTitle extends StatelessWidget {
  MainTitle({
    @required this.title,
    @required this.fontsize,
    @required this.fontweight,
  });

  final title, fontsize, fontweight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.sizeByWidth(15.0)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontsize,
          fontWeight: fontweight,
        ),
      ),
    );
  }
}

class SubText extends StatelessWidget {
  SubText({
    @required this.description,
    @required this.fontsize,
    @required this.fontweight,
  });

  final description, fontsize, fontweight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.sizeByWidth(13.0)),
      child: Text(
        description,
        style: TextStyle(
          fontSize: fontsize,
          fontWeight: fontweight,
        ),
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  StatusContainer({
    @required this.stat,
    @required this.fontsize,
    @required this.fontweight,
  });

  final stat, fontsize, fontweight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            stat,
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: fontweight,
              color: Color(0xFF0078D4),
            ),
          ),
        ),
      ),
      height: SizeConfig.sizeByHeight(22),
      width: SizeConfig.sizeByWidth(60),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF0078D4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
