import '../models/vacancy.dart';
import '../services/api_service.dart';

class VacanciesService extends ApiService {
  VacanciesService();

  Future<List<Vacancy>> getVacancies() async {
    try {
      final response = await getApi('vacancies/vacancies/');
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
