import 'package:flutter/material.dart';

class SimpleProgressBar extends StatelessWidget{

  int completed;
  double width;
  double height;
  Color color;

  SimpleProgressBar({this.completed = 1, this.width = 0, this.height = 10, this.color = Colors.green});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    if(width == 0)
      width = screenWidth;

    return Container(
        margin: EdgeInsets.symmetric(
        vertical: 10
    ),
    child: Stack(
    children: [
      Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white)
        ),
      ),
      Container(
        height: height,
        width: completed > 0 ? 1 * width : 0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      )
      ]
    )
    );
  }

}