import 'package:jobr/data/enums/mastery.dart';
import 'package:jobr/data/models/language.dart';

class LanguageMastery {
  Language language;
  Mastery mastery;

  LanguageMastery({
    required this.language,
    required this.mastery,
  });

  LanguageMastery.fromJson(Map<dynamic, dynamic> json)
      : language = Language.fromJson(json['language']),
        mastery = MasteryExtension.fromApi(json['mastery']);

  Map<String, dynamic> toJson() {
    return {
      'language': language.id,
      'mastery': mastery.api(),
    };
  }
}
