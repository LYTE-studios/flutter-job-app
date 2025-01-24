class EmployeeType {
  int id;
  String name;

  EmployeeType({required this.id, required this.name});

  EmployeeType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['employee_type'];
}
