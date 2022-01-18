import 'package:e_learning_sc/model/Content.dart';

class Course{
  final String title;
  final String description;
  final String miniDescription;
  final List<Content> contentList;
  final String emoji;

  Course({required this.title, required this.miniDescription, required this.description, required this.contentList,
    required this.emoji});
}