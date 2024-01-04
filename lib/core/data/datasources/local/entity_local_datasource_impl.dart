import 'package:isar/isar.dart';

import 'package:offline_first/core/domain/entities/employee.dart';

import '../../../domain/datasources/local/entity_local_datasource.dart';
import '../../services/local_db_impl.dart';

class EntityLocalDatasourceImpl extends EntityLocalDatasource {
  EntityLocalDatasourceImpl();

  @override
  Future<void> createEmployees(List<EmployeeData> employees) async {
    await IsarDbImpl.instance.writeTxn(() async {
      await IsarDbImpl.instance.employeeDatas.putAllByIndex('id', employees);
    });
  }

  @override
  Future<List<EmployeeData>> getEmployees() async {
    return await IsarDbImpl.instance.employeeDatas.where().findAll();
  }
}
