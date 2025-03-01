import 'package:jobr/data/enums/mastery.dart';
import 'package:jobr/data/enums/weekday.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/language_mastery.dart';
import 'package:jobr/data/models/location_type.dart';
import 'package:jobr/data/models/skill_type.dart';
import 'package:jobr/data/models/vacancy_description.dart';

class Vacancy {
  List<VacancyDescription>? descriptions;
  ContractType? contractType; // Contract type ID
  FunctionType? function; // Function ID
  LocationType? location; // Optional location
  List<SkillType>? skills; // List of skill IDs
  List<Weekday>? weekDays; // Week day
  double? salary; // Salary
  DateTime? jobDate;
  Mastery? expectedMastery;
  List<LanguageMastery>? languages; // List of language IDs
  List<String>? questions; // List of question IDs
  String? mainDescription; // Main job description
  List<String>? tasks; // List of job tasks

  Vacancy({
    this.descriptions,
    this.contractType,
    this.function,
    this.location,
    this.skills,
    this.weekDays,
    this.jobDate,
    this.salary,
    this.expectedMastery,
    this.languages,
    this.questions,
    this.mainDescription,
    this.tasks,
  });

  /// Factory constructor to create a Vacancy object from JSON
  factory Vacancy.fromJson(Map<dynamic, dynamic> json) {
    return Vacancy(
      descriptions: (json['skill']?.isEmpty ?? true)
          ? []
          : json['skill']!.map((e) => VacancyDescription.fromJson(e)).toList(),
      // contractType: ContractType.fromJson(json['contract_type']),
      // function: FunctionType.fromJson(json['function']),
      // location: LocationType.fromJson(json['location']),
      // skills: (json['skill'] ?? []).map((e) => SkillType.fromJson(e)).toList(),
      // weekDays: (json['week_day'] ?? [])
      //     .map((e) => WeekdayExtension.fromApi(e))
      //     .toList(),
      // jobDate:
      //     json['job_date'] != null ? DateTime.parse(json['job_date']) : null,
      // salary: json['salary'] != null ? double.parse(json['salary']) : null,
      // expectedMastery: MasteryExtension.fromApi(json['expected_mastery']),
      // languages: (json['language'] ?? [])
      //     .map((e) => LanguageMastery.fromJson(e))
      //     .toList(),
      // questions: (json['question'] ?? []).map((e) => e.toString()).toList(),
      mainDescription: json['main_description'],
      tasks: (json['tasks'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  /// Method to convert a Vacancy object to JSON
  Map<String, dynamic> toJson() {
    return {
      'descriptions': descriptions?.map((e) => e.toJson()).toList(),
      'contract_type': contractType?.id,
      'function': function?.id,
      'location': location?.id,
      'skill': skills?.map((e) => e.id).toList() ?? [],
      'week_day': [] ?? weekDays?.map((e) => {"name": e.api()}).toList(),
      'job_date': jobDate?.toString(),
      'salary': salary,
      'expected_mastery': expectedMastery?.api(),
      'languages': languages?.map((e) => e.toJson()).toList() ?? [],
      'questions': questions?.map((e) => {'question': e}).toList(),
      'main_description': mainDescription,
      'tasks': tasks,
    };
  }
}
