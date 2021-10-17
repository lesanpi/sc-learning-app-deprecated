import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/screens/course_screen.dart';
import 'package:e_learning_sc/widgets/course_item.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget{


  List<Course> course_list;

  CourseList({required this.course_list});

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    this.screenWidth = screenWidth;

    return Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 0,
          top: 30,
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cursos", style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          ),
          Container(
            width: screenWidth,
            height: 125,
            margin: EdgeInsets.only(
              top: 10
            ),
            child: ListView(
              children: courseListView(course_list, context),
              scrollDirection: Axis.horizontal,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          )
        ],
      ),
    );
  }
  
  List<Widget> courseListView(List<Course> course_list, BuildContext context){
    List<Widget> courseListItems = [];
    course_list.forEach((course) {
      courseListItems.add(courseListItem(course, context));
    });

    return courseListItems;
  }
  
  Widget courseListItem(Course course, BuildContext context){
    return CourseItem(course: course);
  }



}