class SectorType {
  int id;
  String name;

  SectorType({required this.id, required this.name});

  SectorType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['contract_type'];
}
