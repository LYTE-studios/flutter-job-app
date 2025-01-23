class ContractType {
  int id;
  String name;

  ContractType({required this.id, required this.name});

  ContractType.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['contract_type'];
}
