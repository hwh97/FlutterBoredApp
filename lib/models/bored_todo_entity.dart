import 'package:bored/models/bored_entity.dart';
import 'package:bored/services/db/bored_todo_table.dart';

class BoredTodoEntity {
  int id;
  String activity;
  String accessibility;
  String type;
  int participants;
  String price;
  String link;
  String key;
  int status;
  String updateAt;
  String createAt;
  int delFlag;

  BoredTodoEntity(
      {this.id,
      this.activity,
      this.accessibility,
      this.type,
      this.participants,
      this.price,
      this.link,
      this.key,
      this.status,
      this.updateAt,
      this.createAt,
      this.delFlag});

  BoredTodoEntity.fromMap(Map data) {
    this.id = data[BoredTodoTable.id];
    this.activity = data[BoredTodoTable.activity];
    this.accessibility = data[BoredTodoTable.accessibility];
    this.type = data[BoredTodoTable.type];
    this.participants = data[BoredTodoTable.participants];
    this.price = data[BoredTodoTable.price];
    this.link = data[BoredTodoTable.link];
    this.key = data[BoredTodoTable.key];
    this.status = data[BoredTodoTable.status];
    this.updateAt = data[BoredTodoTable.updateAt].toString();
    this.createAt = data[BoredTodoTable.createAt];
    this.delFlag = data[BoredTodoTable.delFlag];
  }

  @override
  bool operator ==(other) {
    return this.id == other.id;
  }
}
