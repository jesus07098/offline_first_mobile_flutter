



import '../../../domain/datasources/remote/entity_remote_datasource.dart';
import '../../../domain/entities/employee.dart';
import '../../services/api_service_impl.dart';

class EntityRemoteDatasourceImpl extends EntityRemoteDatasource {
  final apiService = DioApiService();
  @override
  Future<List<EmployeeData>> getEmployees() async {
    try {
      final response = await apiService.get(
        '/app/employees',
      );

      final employees =  Employee.fromJson(response.data);

      return employees.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}

