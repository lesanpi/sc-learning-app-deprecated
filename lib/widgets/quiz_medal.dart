import 'package:flutter/material.dart';

class QuizMedal extends StatelessWidget{

  double size;
  QuizMedal({this.size = 70});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(size)),
          border: Border.all(width: 5, color: Colors.white),
      ),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logo_white.png'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }

}