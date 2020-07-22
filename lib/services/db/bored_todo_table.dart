import 'package:bored/models/bored_entity.dart';
import 'package:bored/services/db/base_table.dart';
import 'package:bored/services/db/db_table_create_list.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BoredTodoTable extends BaseTable {
  @override
  String get createTableSql => dbTableList[1];

  @override
  String get tableName => "bored_todo";

  // Table columns
  static const String id = "id";
  static const String activity = "activity";
  static const String accessibility = "accessibility";
  static const String type = "type";
  static const String participants = "participants";
  static const String price = "price";
  static const String link = "link";
  static const String key = "key";
  static const String status = "status";
  static const String updateAt = "update_at";
  static const String createAt = "create_at";
  static const String finishAt = "finish_at";
  static const String delFlag = "del_flag";

  Future<List<Map>> getTodoList(int page, int rows) async {
    Database db = await getDatabase();
    String querySql = "select * from $tableName where $delFlag = 0 order by $createAt desc limit $rows offset ${(page -
        1) * rows}";
    List<Map> data = await db.rawQuery(querySql);
    await close();
    return data;
  }

  Future<int> insert(BoredEntity boredEntity) async {
    Database db = await getDatabase();
    int id = await db.insert(tableName, {
      activity: boredEntity.activity,
      accessibility: boredEntity.accessibility,
      type: boredEntity.type,
      participants: boredEntity.participants,
      price: boredEntity.price,
      link: boredEntity.link,
      key: boredEntity.key,
    });
    await close();
    return id;
  }

  Future<int> delete({@required int deleteId}) async {
    Database db = await getDatabase();
    int id = await db.update(tableName, {delFlag: 1}, where: "id = ?", whereArgs: [deleteId]);
    await close();
    return id;
  }

  Future<int> completeBored({@required int boredId}) async {
    Database db = await getDatabase();
    int id = await db.update(tableName, {status: 1, finishAt: DateTime.now().toString()},
        where: "id = ?", whereArgs: [boredId]);
    await close();
    return id;
  }
}
