import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/services/urlUtils.dart';
import 'package:url_launcher/url_launcher.dart';

class TwolineTitle extends StatelessWidget {
  const TwolineTitle({
    @required this.name,
    @required this.subname,
    @required this.stat,
    @required this.more,
    @required this.fontsize1,
    @required this.fontsize2,
    @required this.fontsize3,
    @required this.fontweight1,
    @required this.fontweight2,
    @required this.fontweight3,
    required this.url,
  });

  final String? name, subname, stat, more;
  final double? fontsize1, fontsize2, fontsize3;
  final FontWeight? fontweight1, fontweight2, fontweight3;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.sizeByWidth(24),
          SizeConfig.sizeByHeight(24),
          SizeConfig.sizeByWidth(14),
          SizeConfig.sizeByHeight(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
            name: name,
            fontsize1: fontsize1,
            fontweight1: fontweight1,
          ),
          BottomTitle(
            subname: subname,
            fontsize2: fontsize2,
            fontweight2: fontweight2,
            stat: stat,
            fontsize3: fontsize3,
            fontweight3: fontweight3,
            fontsize4: fontsize3,
            more: more,
            url: url,
          ),
        ],
      ),
    );
  }
}

class BottomTitle extends StatelessWidget {
  const BottomTitle({
    Key? key,
    required this.subname,
    required this.fontsize2,
    required this.fontweight2,
    required this.stat,
    required this.fontsize3,
    required this.fontsize4,
    required this.fontweight3,
    required this.more,
    required this.url,
  }) : super(key: key);

  final String? subname;
  final double? fontsize2;
  final FontWeight? fontweight2;
  final String? stat;
  final double? fontsize3;
  final double? fontsize4;
  final FontWeight? fontweight3;
  final String? more;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            child: Row(
              children: [
                SubTitle(
                  title: subname,
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
        MoreText(
          description: more,
          fontsize: fontsize4,
          fontweight: fontweight2,
          urlName: url,
        ),
      ],
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({
    Key? key,
    @required this.name,
    @required this.fontsize1,
    @required this.fontweight1,
  }) : super(key: key);

  final String? name;
  final double? fontsize1;
  final FontWeight? fontweight1;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(11.0)),
        child: Text(
          name ?? '',
          style: TextStyle(
            color: Color(0xFF353B45),
            fontSize: fontsize1,
            fontWeight: fontweight1,
          ),
        ),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  SubTitle({
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
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByHeight(7)),
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
      // width: SizeConfig.sizeByWidth(60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class MoreText extends StatelessWidget {
  MoreText({
    @required this.description,
    @required this.fontsize,
    @required this.fontweight,
    required this.urlName,
  });

  final description, fontsize, fontweight;
  final String urlName;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ElevatedButton(
          onPressed: () {
            UrlUtils.launchURL(urlName);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextBox(description, 12, FontWeight.w500, Color(0xFF353B45)),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: SizeConfig.sizeByHeight(12),
                color: Color(0xFF353B45),
              )
            ],
          )),
    );
  }
}
