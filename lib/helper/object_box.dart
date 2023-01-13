
import 'package:offline_first_mobile_flutter/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  ObjectBox._init(this._store);

  static Future<ObjectBox> init() async {
    final store= await openStore();

    return ObjectBox._init(store);
  }
}
