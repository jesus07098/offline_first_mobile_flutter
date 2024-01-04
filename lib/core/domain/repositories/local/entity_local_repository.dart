import '../../entities/entities.dart';

abstract class EntityLocalRepository {

  Future<void> createEmployees(List<EmployeeData> employees);
  Future<List<EmployeeData>> getEmployees();
}
