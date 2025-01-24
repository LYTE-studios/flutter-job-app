import 'package:jobr/data/models/question.dart';

class VacancyDescription {
  Question question;
  String description;

  VacancyDescription({
    required this.question,
    required this.description,
  });

  VacancyDescription.fromJson(Map<dynamic, dynamic> json)
      : question = Question.fromJson(json['question']),
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'question': question.id,
      'description': description,
    };
  }
}
