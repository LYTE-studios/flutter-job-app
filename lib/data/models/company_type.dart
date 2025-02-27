class CompanyType {
  int id;
  String name;

  CompanyType({required this.id, required this.name});

  CompanyType.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['company_type'];
}
