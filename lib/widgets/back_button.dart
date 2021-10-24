import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget{

  double size;
  Color color;

  MyBackButton({this.size = 50, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Icon(Icons.arrow_back_ios, color: color, size: size,), decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))
      )
      ),
      onTap: (){
        Navigator.pop(context);
      },
    );
  }

}