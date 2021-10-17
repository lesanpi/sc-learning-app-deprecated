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
                border: Border.all(color: Colors.white)
            ),
          ),
          FutureBuilder(
            future: _progress,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){

              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return Container();
                default:
                  return Container(
                    height: widget.height,
                    width: widget.width * (snapshot.data == null ? 0 : snapshot.data!.toInt()) / widget.total,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                    ),
                  );
              }


            },
          )
        ],
      ),
    );
  }

}
