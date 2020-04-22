import 'package:bored/service_locator.dart';
import 'package:bored/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseTable {
  String get tableName;
  String get createTableSql;

  Future<Database> getDatabase() async {
    return await _open();
  }

  Future close() async {
    return serviceLocator.get<DbUtil>().close();
  }

  Future<Database> _open() async {
    DbUtil dbUtil = serviceLocator.get<DbUtil>();
    Database database = await dbUtil.getDatabase();
    bool isTableExist = await dbUtil.isTableExist(tableName);
    if (!isTableExist) {
      await database.execute(createTableSql);
    }
    return database;
  }
}