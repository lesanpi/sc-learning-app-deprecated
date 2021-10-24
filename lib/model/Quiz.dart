import 'package:e_learning_sc/model/Question.dart';

class Quiz{
  String id;
  String title;
  String description;
  List<Question> questions;

  Quiz({required this.id, required this.title, required this.questions, this.description = ""});
}