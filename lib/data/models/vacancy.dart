class Vacancy {
  final int employer; // Employer ID
  final String title; // Title of the vacancy
  final int contractType; // Contract type ID
  final int functionId; // Function ID
  final String? location; // Optional location
  final List<int> skills; // List of skill IDs
  final String weekDay; // Week day
  final double salary; // Salary
  final String description; // Description of the vacancy
  final List<int> languages; // List of language IDs
  final List<int> questions; // List of question IDs
  final double? latitude; // Optional latitude
  final double? longitude; // Optional longitude

  Vacancy({
    required this.employer,
    required this.title,
    required this.contractType,
    required this.functionId,
    this.location,
    required this.skills,
    required this.weekDay,
    required this.salary,
    required this.description,
    required this.languages,
    required this.questions,
    this.latitude,
    this.longitude,
  });

  /// Factory constructor to create a Vacancy object from JSON
  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      employer: json['employer'],
      title: json['title'],
      contractType: json['contract_type'],
      functionId: json['function'],
      location: json['location'],
      skills: List<int>.from(json['skill'] ?? []),
      weekDay: json['week_day'],
      salary: double.parse(json['salary']),
      description: json['description'],
      languages: List<int>.from(json['language'] ?? []),
      questions: List<int>.from(json['question'] ?? []),
      latitude:
          json['latitude'] != null ? double.parse(json['latitude']) : null,
      longitude:
          json['longitude'] != null ? double.parse(json['longitude']) : null,
    );
  }

  /// Method to convert a Vacancy object to JSON
  Map<String, dynamic> toJson() {
    return {
      'employer': employer,
      'title': title,
      'contract_type': contractType,
      'function': functionId,
      'location': location,
      'skill': skills,
      'week_day': weekDay,
      'salary': salary.toString(),
      'description': description,
      'language': languages,
      'question': questions,
      'latitude': latitude?.toString(),
      'longitude': longitude?.toString(),
    };
  }
}
