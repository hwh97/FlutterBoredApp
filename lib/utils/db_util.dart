import 'package:bored/service_locator.dart';
import 'package:bored/services/db/db_table_create_list.dart';
import 'package:bored/utils/logger/logger.dart';
import 'package:bored/utils/path_util.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static const String _dbName = "bored";
  static const int _version = 2;
  Database _db;

  Future<DbUtil> init() async {
    PathUtil pathUtil = serviceLocator.get<PathUtil>();
    String dbPath = pathUtil.documentPath + "/db/$_dbName.db";
    try {
      if (_db != null && _db.isOpen) {
        await _db.close();
      }
      _db = await openDatabase(dbPath,
          version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (_) {
      logger.e("open database error ${_.toString()}");
    }
    return this;
  }

  Future _onCreate(Database db, int version) async {
    var batch = db.batch();
    dbTableList.forEach((item) => batch.execute(item));
    batch.commit();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    bool isHasUpdateSql =
        updateDbTableList.keys.contains("$oldVersion\_$newVersion");
    logger.d(
        "start update database, $oldVersion - $newVersion, isHasUpdateSql: $isHasUpdateSql");
    if (isHasUpdateSql) {
      // execute database update logic
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.execute(updateDbTableList["$oldVersion\_$newVersion"]);
        await batch.commit();
      });
    } else {
      // execute create sql default
      await _onCreate(db, newVersion);
    }
  }

  Future<Database> getDatabase() async {
    if (_db == null) {
      await init();
    }
    return _db;
  }

  Future<bool> isTableExist(String tableName) async {
    await getDatabase();
    String querySql =
        "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _db.rawQuery(querySql);
    return res != null && res.length > 0;
  }

  Future close() async {
    await _db?.close();
    _db = null;
  }
}
