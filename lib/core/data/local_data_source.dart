import 'package:hive_flutter/hive_flutter.dart';

class LocalDataSource {
  Future<void> postData<T>(String dbName, String key, dynamic value) async {
    Box<T> box = Hive.box<T>(dbName);
    await box.put(key, value);
  }
}