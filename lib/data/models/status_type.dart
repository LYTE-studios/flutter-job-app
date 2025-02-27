class StatusType {
  int id;
  String name;

  StatusType({required this.id, required this.name});

  StatusType.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['status_type'];
}
