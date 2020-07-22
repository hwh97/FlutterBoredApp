import 'package:bored/service_locator.dart';
import 'package:bored/services/db/bored_todo_table.dart';

final List<String> dbTableList = ["DROP TABLE IF EXISTS bored_todo",
  """
    CREATE TABLE ${serviceLocator.get<BoredTodoTable>().tableName} (
      ${BoredTodoTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${BoredTodoTable.activity} TEXT NOT NULL,
      ${BoredTodoTable.accessibility} TEXT,
      ${BoredTodoTable.type} TEXT,
      ${BoredTodoTable.participants} INTEGER,
      ${BoredTodoTable.price} TEXT,
      ${BoredTodoTable.link} TEXT,
      ${BoredTodoTable.key} TEXT,
      ${BoredTodoTable.status} INTEGER DEFAULT 0,
      ${BoredTodoTable.updateAt} TIMESTAMP DEFAULT 0,
      ${BoredTodoTable.finishAt} TIMESTAMP DEFAULT 0,
      ${BoredTodoTable.createAt} TIMESTAMP DEFAULT (datetime('now','localtime')),
      ${BoredTodoTable.delFlag} INTEGER DEFAULT 0
    )
  """,
];

final Map<String, String> updateDbTableList =
    {"1_2":
            """
            ALTER TABLE bored_todo ADD COLUMN ${BoredTodoTable.finishAt} TIMESTAMP DEFAULT 0
            """,
    };