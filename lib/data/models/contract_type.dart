class ContractType {
  int id;
  String name;

  ContractType({required this.id, required this.name});

  ContractType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['contract_type'];
}
