enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension WeekdayExtension on Weekday {
  static Weekday fromApi(String api) {
    switch (api) {
      case "monday":
        return Weekday.monday;
      case "tuesday":
        return Weekday.tuesday;
      case "wednesday":
        return Weekday.wednesday;
      case "thursday":
        return Weekday.thursday;
      case "friday":
        return Weekday.friday;
      case "saturday":
        return Weekday.saturday;
      case "sunday":
        return Weekday.sunday;
    }

    throw Exception("Invalid weekday type");
  }

  String api() {
    switch (this) {
      case Weekday.monday:
        return "monday";
      case Weekday.tuesday:
        return "tuesday";
      case Weekday.wednesday:
        return "wednesday";
      case Weekday.thursday:
        return "thursday";
      case Weekday.friday:
        return "friday";
      case Weekday.saturday:
        return "saturday";
      case Weekday.sunday:
        return "sunday";
    }
  }
}
