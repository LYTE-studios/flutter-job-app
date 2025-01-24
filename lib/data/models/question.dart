class Question {
  int? id;
  String name;

  Question({
    required this.id,
    required this.name,
  });

  Question.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['question'];
}
