import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressBar extends StatefulWidget{
  int total;
  String id;
  late Future<int> progress;
  double height;
  double width;

  ProgressBar({required this.total, required this.id, this.height = 10, this.width = 0});

  @override
  State<StatefulWidget> createState() {

    return ProgressBarState();
  }
}

class ProgressBarState extends State<ProgressBar>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _progress;

  @override
  void initState() {
    super.initState();
    _progress = _prefs.then((SharedPreferences prefs){
      return (prefs.getInt(widget.id) ?? 0);
    });
    //print(_progress);

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if(widget.width == 0)
      setState(() {
        widget.width = screenWidth;
      });

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 10
      ),
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white),
              color: Color.fromRGBO(0, 0, 0, 0.1)
            ),
          ),
          FutureBuilder(
            future: _progress,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              //print("Progress ${widget.id} ${snapshot.data} ${widget.total}");


              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return Container();
                default:

                  if(snapshot.hasError){
                    return Container();
                  }else {
                    double progressWidth = widget.width * (snapshot.data!.toInt()) / widget.total;
                    if ((snapshot.data!.toInt()) > widget.total)
                      progressWidth = widget.width;
                    return Container(
                      height: widget.height,
                      width: progressWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white
                      ),
                    );
                  }
              }


            },
          )
        ],
      ),
    );
  }

}
