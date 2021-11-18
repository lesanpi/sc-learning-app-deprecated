import 'package:e_learning_sc/model/Content.dart';

class Course{
  final String title;
  final String description;
  final String miniDescription;
  final List<Content> contentList;

  Course({required this.title, required this.miniDescription, required this.description, required this.contentList});
}