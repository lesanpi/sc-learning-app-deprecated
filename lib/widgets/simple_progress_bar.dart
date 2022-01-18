import 'package:e_learning_sc/model/App.dart';
import 'package:flutter/material.dart';

class SimpleProgressBar extends StatelessWidget{

  int completed;
  double width;
  double height;
  Color color;

  SimpleProgressBar({this.completed = 1, this.width = 0, this.height = 10, this.color = App.greenProgress});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    if(width == 0)
      width = screenWidth;

    return Container(

    child: Stack(
    children: [
      Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black12)
        )
        ),
      ),
      Container(
        height: height,
        width: completed > 0 ? 1 * width : 0,
        decoration: BoxDecoration(
          color: color,
        ),
      )
      ]
    )
    );
  }

}