import 'package:e_learning_sc/model/App.dart';
import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  String option;
  bool selected;
  QuestionOption({required this.option, this.selected = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final colorSelected = isDarkTheme ? App.gold : Colors.blueAccent;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: selected ? colorSelected : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 100, 0.3),
            blurRadius: 0.1,
            spreadRadius: 0.1,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        option,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black87, fontSize: 16),
      ),
    );
  }
}
