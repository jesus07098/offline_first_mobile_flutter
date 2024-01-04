

import '../../entities/employee.dart';

abstract class EntityRemoteRepository {
  Future<List<EmployeeData>> getEmployees();
}