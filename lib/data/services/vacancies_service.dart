import '../services/api_service.dart';
import '../models/vacancy.dart';

class VacanciesService {
  final ApiService _apiService;

  VacanciesService() : _apiService = ApiService();

  Future<List<Vacancy>> getVacancies() async {
    try {
      final response = await _apiService.dio.get('vacancies/');
      return (response.data as List)
          .map((json) => Vacancy.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch vacancies: $e');
    }
  }

  Future<Vacancy> applyForVacancy(int vacancyId, int employeeId) async {
    try {
      final response = await _apiService.dio.post('vacancies/$vacancyId/apply/',
          data: {'employee_id': employeeId});
      return Vacancy.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to apply for vacancy: $e');
    }
  }
}
