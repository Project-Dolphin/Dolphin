import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/bus_controller.dart';

class Dropdown extends StatefulWidget {
  const Dropdown(this.itemList, this.selectedItem, this.setItemState,
      {this.findTitle, this.findSubTitle, Key? key})
      : super(key: key);

  final List<String> itemList;

  final String selectedItem;
  final Function setItemState;
  final Function? findTitle;
  final Function? findSubTitle;

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool isDropdownOpen = false;
  double dropdownWidth = SizeConfig.sizeByWidth(200);
  @override
  Widget build(BuildContext context) {
    Get.put(BusController());

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
              width: dropdownWidth,
              height: SizeConfig.sizeByHeight(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFFBFBFB),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 6),
                    blurRadius: 20,
                    spreadRadius: -5,
                    color: Color(0xFFA9A9A9).withOpacity(0.21),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.sizeByHeight(4),
                  horizontal: SizeConfig.sizeByWidth(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.sizeByWidth(7)),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          TextBox(
                              widget.findTitle != null
                                  ? widget.findTitle!(widget.selectedItem) ??
                                      widget.selectedItem
                                  : widget.selectedItem,
                              16 * 0.9,
                              FontWeight.w700,
                              Color(0xFF353B45)),
                          widget.findSubTitle != null
                              ? widget.findSubTitle!(widget.selectedItem) != ''
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: SizeConfig.sizeByHeight(8),
                                        ),
                                        Text(
                                          widget.findSubTitle!(
                                              widget.selectedItem),
                                          style: TextStyle(
                                            color: Color(0xFF4BA6FF),
                                            fontSize: 14 * 0.9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: SizeConfig.sizeByWidth(2)),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Image.asset(
                        "assets/images/dropdown/dropdownIcon.png",
                        width: SizeConfig.sizeByWidth(14),
                        height: SizeConfig.sizeByWidth(14),
                      ),
                    ),
                  )
                ],
              )),
        ),
        SizedBox(
          height: 5,
        ),
        isDropdownOpen
            ? Container(
                width: dropdownWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFFAFAFA),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 6),
                      blurRadius: 20,
                      spreadRadius: -5,
                      color: Color(0xFFA9A9A9).withOpacity(0.21),
                    )
                  ],
                ),
                child: Column(
                  children: widget.itemList
                      .map((item) => GestureDetector(
                            onTap: () {
                              widget.setItemState(item);
                              setState(() {
                                isDropdownOpen = !isDropdownOpen;
                              });
                            },
                            child: (Container(
                              width: SizeConfig.sizeByWidth(194),
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.sizeByHeight(8)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: widget.selectedItem == item
                                    ? Color(0xFF4BA6FF)
                                    : Colors.transparent,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.sizeByWidth(8)),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        item.contains('출근')
                                            ? item.replaceFirst(' 출근', '')
                                            : item.contains('퇴근')
                                                ? item.replaceFirst(' 퇴근', '')
                                                : item,
                                        style: TextStyle(
                                            color: widget.selectedItem == item
                                                ? Colors.white
                                                : Color(0xFF353B45),
                                            fontSize: 16 * 0.9,
                                            fontWeight:
                                                widget.selectedItem == item
                                                    ? FontWeight.w700
                                                    : FontWeight.w400),
                                      ),
                                      widget.findSubTitle != null
                                          ? widget.findSubTitle!(item) != ''
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      width: SizeConfig
                                                          .sizeByHeight(8),
                                                    ),
                                                    Text(
                                                      widget.findSubTitle!(
                                                              item) ??
                                                          item,
                                                      style: TextStyle(
                                                        color:
                                                            widget.selectedItem ==
                                                                    item
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFF4BA6FF),
                                                        fontSize: 14 * 0.9,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    item == '주변정류장'
                                                        ? Row(children: [
                                                            SizedBox(
                                                              width: SizeConfig
                                                                  .sizeByWidth(
                                                                      8),
                                                            ),
                                                            Transform.rotate(
                                                              angle: 0.7,
                                                              child: Icon(
                                                                Icons
                                                                    .navigation_outlined,
                                                                size: SizeConfig
                                                                    .sizeByHeight(
                                                                  14,
                                                                ),
                                                                color: widget
                                                                            .selectedItem ==
                                                                        item
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xFF4BA6FF),
                                                              ),
                                                            )
                                                          ])
                                                        : Container()
                                                  ],
                                                )
                                              : Container()
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ))
                      .toList(),
                ),
              )
            : Container(),
      ],
    );
  }
}
