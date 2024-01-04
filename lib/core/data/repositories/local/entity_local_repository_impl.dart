import 'package:offline_first/core/domain/entities/employee.dart';

import '../../../domain/datasources/local/entity_local_datasource.dart';
import '../../../domain/repositories/local/entity_local_repository.dart';
import '../../datasources/local/entity_local_datasource_impl.dart';

class EntityLocalRepositoryImpl extends EntityLocalRepository {
  final EntityLocalDatasource datasource;
  EntityLocalRepositoryImpl({EntityLocalDatasourceImpl? datasource})
      : datasource =
            datasource ?? EntityLocalDatasourceImpl();


  @override
  Future<void> createEmployees(List<EmployeeData> employees) {
    return datasource.createEmployees(employees);
  }

  @override
  Future<List<EmployeeData>> getEmployees() {
    return datasource.getEmployees();
  }
}
