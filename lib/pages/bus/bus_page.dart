import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'bus_controller.dart';

class BusPage extends GetView<BusController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CarouselWithIndicatorDemo(),
        ),
      ),
    );
  }
}

class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CarouselSlider(
            items: list
                .map((item) => Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Center(child: Text(item.toString())),
                      color: Colors.grey,
                    ))
                .toList(),
            options: CarouselOptions(
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
            ),
            carouselController: _controller,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ...Iterable<int>.generate(list.length).map(
                    (int pageIndex) => Flexible(
                      child: InkWell(
                        onTap: () {
                          _controller.animateToPage(pageIndex);
                        },
                        child: Ink(
                          height: 40,
                          child: Center(child: Text("$pageIndex")),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  List<int> list = [11, 22, 33, 44];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: list
                  .map((item) => Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Center(
                          child: Text(
                            item.toString(),
                          ),
                        ),
                        color: Colors.grey,
                      ))
                  .toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                aspectRatio: 2.0,
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
          Container(
            height: 40,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: list.asMap().entries.map(
                (entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.blue)
                                  .withOpacity(_current == entry.key ? 0.8 : 0),
                          borderRadius: BorderRadius.circular(
                              _current == entry.key ? 10 : 0)),
                      child: Center(
                          child: Text(entry.key == 0
                              ? '190번'
                              : entry.key == 1
                                  ? '셔틀버스'
                                  : entry.key == 2
                                      ? '통근버스'
                                      : '학교버스')),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
