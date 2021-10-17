import 'dart:convert';
import 'package:e_learning_sc/model/Content.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';

import 'Course.dart';

class App{

  var _data;

  List<Course> courseList(var data){
    List<Course> _courseList = [];
    for(int i = 0; i < data.length; i++){

      _courseList.add(Course(
          title: data[i]["title"], 
          description: data[i]["description"],
          mini_description: data[i]["mini_description"],
          content_list: contentList(data[i]["content"])
      ));
    }

    return _courseList;
  }

  List<Content> contentList(var dataContent){
    List<Content> _contentList = [];

    for(int i = 0; i < dataContent.length; i++){
      if (dataContent[i]["type"] == "lesson")
        _contentList.add(Lesson(
          title: dataContent[i]["title"],
          description: dataContent[i]["description"],
          image_url: dataContent[i]["img_url"],
          video_url: dataContent[i]["url"]
        ));
      else
        _contentList.add(Guide(
            title: dataContent[i]["title"],
            img_url: dataContent[i]["img_url"],
            url: dataContent[i]["url"]
        ));
    }

    return _contentList;
  }

}