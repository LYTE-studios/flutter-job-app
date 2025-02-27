class FunctionType {
  int id;
  String name;

  FunctionType({required this.id, required this.name});

  FunctionType.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['function'];
}
