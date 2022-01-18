import 'package:flutter/material.dart';

class QuizMedal extends StatelessWidget{

  double size;
  Color background_color;
  String emoji;
  double emojiSize;
  QuizMedal({this.size = 70, this.background_color = Colors.white24, this.emoji ="⛔", this.emojiSize =30});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: background_color,
          borderRadius: BorderRadius.all(Radius.circular(size)),
          border: Border.all(width: 5, color: Colors.white),
      ),
      child: Container(
        /*decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logo_white.png'),
                fit: BoxFit.cover
            )
        ),*/
        child: Center(
          child: Text(emoji, style: TextStyle(fontSize: emojiSize),),
        )
      ),
    );
  }

}