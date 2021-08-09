import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class OnelineTitle extends StatelessWidget {
  const OnelineTitle({
    Key? key,
    @required this.name,
    @required this.description,
    @required this.stat,
    @required this.fontsize1,
    @required this.fontsize2,
    @required this.fontsize3,
    @required this.fontweight1,
    @required this.fontweight2,
    @required this.fontweight3,
    this.isGradient = false,
  }) : super(key: key);
  final bool isGradient;
  final String? name, description, stat;
  final double? fontsize1, fontsize2, fontsize3;
  final FontWeight? fontweight1, fontweight2, fontweight3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.fromLTRB(SizeConfig.sizeByHeight(24),
              SizeConfig.sizeByHeight(24), 0, SizeConfig.sizeByHeight(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MainTitle(
                title: name,
                fontsize: fontsize1,
                fontweight: fontweight1,
                isGradient: isGradient,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  SizedBox(
                    height: SizeConfig.sizeByHeight(
                        (fontsize1! - fontsize2!) * 0.2),
                  )
                ],
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
    required this.isGradient,
  });
  final bool isGradient;
  final title, fontsize, fontweight;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = isGradient
        ? LinearGradient(
            colors: <Color>[Color(0xFF009DF5), Color(0xFF1E7AFF)],
          ).createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 50.0))
        : LinearGradient(
            colors: <Color>[Color(0xff000000), Color(0xff000000)],
          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.sizeByWidth(15.0)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: fontweight,
            foreground: Paint()..shader = linearGradient),
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
