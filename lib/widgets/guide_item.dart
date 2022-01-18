import 'dart:io';
import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

var dio = Dio();

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class GuideItem extends StatelessWidget{

  double height = 70;
  double width = 100;
  Guide guide;
  bool mini;

  GuideItem({required this.guide, this.width = 100, this.height = 70, this.mini=false});

  void _requestDownload() async {

    var tempDir = await getTemporaryDirectory();
    String fullPath = tempDir.path + "/boo2.pdf'";
    print('full path ${fullPath}');

    download2(dio, fullPath);
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }


  Future download2(Dio dio, String savePath) async {
    try {
      Response response = await dio.get(
        guide.url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
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
              child: Text("📖", style: TextStyle(fontSize: 25),),
              /*Icon(
                CupertinoIcons.arrow_uturn_right_circle_fill,
                color: App.myBlack,//App.primaryColor,
                size: 35,
              ),*/
              onTap:  () async {
                var tempDir = await getTemporaryDirectory();
                String fullPath = tempDir.path + "/boo2.pdf'";
                print('full path ${fullPath}');

                download2(dio, fullPath);
              },
            ),
            Container(
              child: Text(guide.title, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF333333),//Colors.black87,
              ),),
              margin: EdgeInsets.symmetric(
                  horizontal: 10
              ),
            )

          ],
        ),

      );

    return InkWell(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(
            top: 10,
            bottom: 10
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
            /*Container(
              width: height * 0.7,
              height: height * 0.7,
              decoration: BoxDecoration(
                  color: App.myBlack,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                /*BorderRadius.horizontal(
                    left: Radius.circular(30)
                )*/
              ),
              child: Icon(CupertinoIcons.arrow_turn_up_right, color: Colors.white,),
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),*/
            Container(
              child: Text("📘", style: TextStyle(fontSize: 25),),
              margin: //EdgeInsets.symmetric(horizontal: 10),
              EdgeInsets.only(
                left: 20
              )
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
                  color: Color(0xFF333333),//Colors.black54
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
      ),
      onTap: () async {
        print(guide.url);
        launchURL(guide.url);
      },
    );
  }

}


/*
Container(
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
                  color: Color(0xFF333333),//Colors.black54
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
*/
