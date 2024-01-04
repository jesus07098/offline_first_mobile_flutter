import 'package:offline_first/core/data/services/local_db_impl.dart';
import 'package:offline_first/core/domain/entities/vehicle.dart';
import 'package:isar/isar.dart';

import '../../../domain/datasources/local/vehicle_local_datasource.dart';

class VehicleLocalDatasourceImpl extends VehicleLocalDatasource {
  @override
  Future<void> createVehicles(vehicles) async {
    await IsarDbImpl.instance.writeTxn(() async {
      await IsarDbImpl.instance.vehicleDatas
          .putAllByIndex('id', vehicles);
    });
  }

  @override
  Future<List<VehicleData>> getVehicles() async {
    return await IsarDbImpl.instance.vehicleDatas.where().findAll();
  }
}
