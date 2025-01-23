enum UserType { employee, employer }

extension UserTypeExtension on UserType {
  String api() {
    switch (this) {
      case UserType.employee:
        return "employee";
      case UserType.employer:
        return "employer";
    }
  }
}

class User {
  final int id;
  final String username;
  final String email;

  User({required this.id, required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}

class Employee {
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String? cityName;
  final String? biography;
  final int user;
  final String? latitude;
  final String? longitude;

  Employee({
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    this.cityName,
    this.biography,
    required this.user,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "phone_number": phoneNumber,
      "city_name": cityName,
      "biography": biography,
      "user": user,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class Employer {
  final String vatNumber;
  final String companyName;
  final String streetName;
  final String houseNumber;
  final String city;
  final String postalCode;
  final Map<String, String> coordinates;
  final String? website;
  final String? biography;
  final int user;

  Employer({
    required this.vatNumber,
    required this.companyName,
    required this.streetName,
    required this.houseNumber,
    required this.city,
    required this.postalCode,
    required this.coordinates,
    this.website,
    this.biography,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      "vat_number": vatNumber,
      "company_name": companyName,
      "street_name": streetName,
      "house_number": houseNumber,
      "city": city,
      "postal_code": postalCode,
      "coordinates": coordinates,
      "website": website,
      "biography": biography,
      "user": user,
    };
  }
}
