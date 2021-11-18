import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:flutter/material.dart';

class GuideItem extends StatelessWidget{

  double height = 70;
  double width = 100;
  Guide guide;
  bool mini;

  GuideItem({required this.guide, this.width = 100, this.height = 70, this.mini=false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    this.width = screenWidth - 20;

    if (this.mini)
      return Container(
        width: screenWidth,
        height: 80,
        margin: EdgeInsets.only(
          top: 1,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 1,
                spreadRadius: 0.1,
              )
            ]

        ),
        child: Row(
          children: [
            InkWell(
              child: Icon(
                Icons.description,
                color: App.primaryColor,
                size: 35,
              ),
            ),
            Container(
              child: Text(guide.title, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black87,
              ),),
              margin: EdgeInsets.symmetric(
                  horizontal: 10
              ),
            )

          ],
        ),

      );

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(
          top: 10,
        bottom: 10
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 1,
              spreadRadius: 0.1,
            )
          ]
      ),
      //padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
                color: App.primaryColor,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10)
                )
            ),
          ),
          Container(
            width: width - height - 20,
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            child: Text(guide.title, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black54
              ),
            ),
          )
          /*Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10
            ),
            width: this.width,
            child: Container(),
            constraints: BoxConstraints(maxWidth: screenWidth - 20 - height),
          )*/
        ],
      ),
    );
  }

}