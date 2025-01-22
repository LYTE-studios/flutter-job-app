class LocationType {
  int id;
  String name;

  LocationType({required this.id, required this.name});

  LocationType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['location'];
}
