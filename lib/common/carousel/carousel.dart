import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:getx_app/common/sizeConfig.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> pageList;
  final List<String> titleList;

  const Carousel({Key key, @required this.pageList, @required this.titleList})
      : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

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
                items: widget.pageList
                    .map((item) => Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 15, 60),
                          child: Column(
                            children: [item],
                          ),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  height: SizeConfig.blockSizeVertical * 100,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _current = index;
                      },
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.sizeByHeight(40),
                margin: EdgeInsets.all(SizeConfig.sizeByWidth(20)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: widget.pageList.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: (SizeConfig.blockSizeHorizontal * 90) /
                              widget.pageList.length,
                          decoration: BoxDecoration(
                              gradient: _current == entry.key
                                  ? LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF009DF5),
                                        Color(0xFF1E7AFF),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp)
                                  : null,
                              boxShadow: _current == entry.key
                                  ? [
                                      BoxShadow(
                                          color: Color(0xFFB4D5F1),
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          spreadRadius: 2)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  _current == entry.key ? 10 : 0)),
                          child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.titleList[entry.key],
                                  style: TextStyle(
                                      color: _current == entry.key
                                          ? Colors.white
                                          : Color(0xFF919191),
                                      fontSize: SizeConfig.sizeByWidth(16),
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
