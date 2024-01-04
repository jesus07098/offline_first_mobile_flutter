import 'package:offline_first/core/domain/entities/entities.dart';

abstract class EntityLocalDatasource {
  Future<void> createEmployees(List<EmployeeData> employees);
  Future<List<EmployeeData>> getEmployees();
}
