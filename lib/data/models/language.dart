class Language {
  int id;
  String name;

  Language({required this.id, required this.name});

  Language.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['language'];
}
