

import '../../../domain/datasources/remote/entity_remote_datasource.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/repositories/remote/entity_remote_repository.dart';
import '../../datasources/remote/entity_remote_datasource_impl.dart';

class EntityRemoteRepositoryImpl extends EntityRemoteRepository {
  final EntityRemoteDatasource datasource;
  EntityRemoteRepositoryImpl({EntityRemoteDatasourceImpl? datasource})
      : datasource =
            datasource ?? EntityRemoteDatasourceImpl();

  @override
  Future<List<EmployeeData>> getEmployees() {
    return datasource.getEmployees();
  }
}
