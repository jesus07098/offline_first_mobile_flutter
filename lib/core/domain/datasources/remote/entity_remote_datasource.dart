import '../../entities/employee.dart';

abstract class EntityRemoteDatasource {
  Future<List<EmployeeData>> getEmployees();
}