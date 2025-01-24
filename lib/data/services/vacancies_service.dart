import 'dart:ffi';

import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/language.dart';
import 'package:jobr/data/models/location_type.dart';

import '../models/vacancy.dart';
import '../services/api_service.dart';

class VacanciesService extends ApiService {
  VacanciesService();

  Future<List<LocationType>> getLocationTypes() async {
    try {
      final response = await getApi(
        'vacancies/locations',
        cacheDuration: Duration(
          minutes: 30,
        ),
      );
      return (response.data as List)
          .map((json) => LocationType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch location: $e');
    }
  }

  Future<List<ContractType>> getContractTypes() async {
    try {
      final response = await getApi(
        'vacancies/contracts',
        cacheDuration: Duration(
          minutes: 30,
        ),
      );
      return (response.data as List)
          .map((json) => ContractType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch contracts: $e');
    }
  }

  Future<List<Language>> getLanguages() async {
    try {
      final response = await getApi(
        'vacancies/languages',
        cacheDuration: Duration(
          minutes: 30,
        ),
      );
      return (response.data as List)
          .map((json) => Language.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch languages: $e');
    }
  }

  Future<List<FunctionType>> getFunctionTypes() async {
    try {
      final response = await getApi(
        'vacancies/functions',
        cacheDuration: Duration(
          minutes: 30,
        ),
      );
      return (response.data as List)
          .map((json) => FunctionType.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch functions: $e');
    }
  }

  Future<void> createVacancy(Vacancy vacancy) async {
    try {
      await postApi(
        'vacancies/vacancies',
        data: vacancy.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create vacancy: $e');
    }
  }

  Future<List<Vacancy>> getVacancies() async {
    try {
      final response = await getApi(
        'vacancies/vacancies',
        cacheDuration: Duration(
          minutes: 30,
        ),
      );
      return (response.data as List)
          .map((json) => Vacancy.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch vacancies: $e');
    }
  }

  Future<Vacancy> applyForVacancy(int vacancyId, int employeeId) async {
    try {
      final response = await postApi(
        'vacancies/$vacancyId/apply/',
        data: {
          'employee_id': employeeId,
        },
      );
      return Vacancy.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to apply for vacancy: $e');
    }
  }
}
