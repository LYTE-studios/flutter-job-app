import 'package:jobr/data/enums/mastery.dart';

class SkillType {
  int id;
  String name;
  Mastery mastery;

  SkillType({
    required this.id,
    required this.name,
    required this.mastery,
  });

  SkillType.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['skill'],
        mastery = MasteryExtension.fromApi(json['mastery']);
}
