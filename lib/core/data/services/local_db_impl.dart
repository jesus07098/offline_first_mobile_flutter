import 'package:offline_first/features/incidents/domain/entities/incident.dart';
import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:offline_first/core/domain/entities/entities.dart';

import 'local_db.dart';

class IsarDbImpl extends LocalDb {
  static late final Isar _db;

  @override
  Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open([VehicleDataSchema, EmployeeDataSchema, IncidentSchema, TypeIncidentDataSchema],
        directory: dir.path, inspector: true);
  }

  @override
  Future<void> cleanDb() async {
    await _db.writeTxn(() => cleanDb());
  }

  static Isar get instance => _db;
}
