enum Mastery { none, beginner, intermediate, advanced, expert }

extension MasteryExtension on Mastery {
  static Mastery fromApi(String api) {
    switch (api) {
      case "none":
        return Mastery.none;
      case "beginner":
        return Mastery.beginner;
      case "intermediate":
        return Mastery.intermediate;
      case "advanced":
        return Mastery.advanced;
      case "expert":
        return Mastery.expert;
    }

    throw Exception("Invalid mastery type");
  }

  String api() {
    switch (this) {
      case Mastery.none:
        return "none";
      case Mastery.beginner:
        return "beginner";
      case Mastery.intermediate:
        return "intermediate";
      case Mastery.advanced:
        return "advanced";
      case Mastery.expert:
        return "expert";
    }
  }
}
