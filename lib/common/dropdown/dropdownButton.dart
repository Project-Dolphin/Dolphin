import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown(this.itemList, this.selectedItem, this.setItemState, {Key key})
      : super(key: key);

  final List<String> itemList;

  final String selectedItem;
  final Function setItemState;

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool isDropdownOpen = false;
  double dropdownWidth = 160;
  @override
  Widget build(BuildContext context) {
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
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0797F8), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 6),
                    blurRadius: 20,
                    spreadRadius: -5,
                    color: Color(0xFFA9A9A9).withOpacity(0.21),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Container(
                    width: dropdownWidth,
                    child: Text(
                      widget.selectedItem,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "assets/images/dropdown/dropdownIcon.png",
                      width: 10,
                      height: 10,
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
                  border: Border.all(color: Color(0xFF0797F8), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(0.6),
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
                              width: 158,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: widget.selectedItem == item
                                    ? Color(0xFF52B9FF)
                                    : Colors.transparent,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      color: widget.selectedItem == item
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
