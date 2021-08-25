import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oceanview/common/sizeConfig.dart';

import 'dailyMenu_menu.dart';
import 'dailyMenu_page.dart';




// final CarouselController _controller = CarouselController();
// final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
// final List<dynamic> testPageList = [
//   MealCard(type: 0, time: time),
//   MealCard(type: 1, time: time),
//   MealCard(type: 2, time: time),
//   MealCard(type: 3, time: time),
//   MealCard(type: 4, time: time),
// ];

class MenuState extends StatefulWidget {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<dynamic>? pageList;
  final List<String>? titleList;

  MenuState(
      {Key? key, @required this.pageList, this.titleList,})
      : super(key: key);

  @override
  _MenuStateButton createState() => _MenuStateButton();
}

class _MenuStateButton extends State<MenuState> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.sizeByHeight(46),
        margin: EdgeInsets.all(SizeConfig.sizeByWidth(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                SizeConfig.sizeByHeight(46)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: widget.pageList!.asMap().entries.map(
                (entry) {
              return GestureDetector(
                onTap: () =>
                    widget._controller.animateToPage(entry.key),
                child: Container(
                  width: (SizeConfig.blockSizeHorizontal *
                      90) /
                      widget.pageList!.length,
                  decoration: BoxDecoration(
                      gradient: widget._current == entry.key
                          ? LinearGradient(
                          colors: <Color>[
                            Color(0xFF3199FF),
                            Color(0xFF0081FF),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)
                          : null,
                      boxShadow: widget._current == entry.key
                      ? [
                      BoxShadow(
                          color: Color(0xFFB4D5F1),
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          spreadRadius: 2)
                      ]
                          : null,
                      borderRadius: BorderRadius.circular(
                          widget._current == entry.key
                              ? SizeConfig.sizeByHeight(46)
                              : 0)),
                  child: Center(
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.titleList![entry.key],
                          style: TextStyle(
                              color: widget._current == entry.key
                                  ? Colors.white
                                  : Color(0xFF919191),
                              fontSize:
                              SizeConfig.sizeByWidth(
                                  16),
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class MenuCarousel extends StatefulWidget {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<dynamic>? pageList;
  final List<String>? titleList;

  MenuCarousel(
      {Key? key, @required this.pageList, this.titleList,})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuCarousel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              child: CarouselSlider(
                items: widget.pageList!
                    .map((item) => Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 60),
                  child: Column(
                    children: [item],
                  ),
                ))
                    .toList(),
                carouselController: widget._controller,
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  height: SizeConfig.blockSizeVertical * 100,
                  onPageChanged: (index, reason) {
                    setState(
                          () {
                        widget._current = index;
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
