import 'dart:io';

import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomRoadmapServices {
  Database? _database;
  static const _tableName = "CustomRoadmap";

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    String path = join(await getDatabasesPath(), "CustomRoadmap.db");
    await Directory(dirname(path)).create(recursive: true);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          roadmapName TEXT,
          idRoadmapElement INTEGER,
          roadmapElement TEXT,
          description TEXT,
          isCompleted INTEGER DEFAULT 0
        )
        ''');
      },
    );
  }

  Future<List<CustomRoadmapModel>> getRoadmapsName() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM $_tableName
    GROUP BY roadmapName
    ORDER BY id ASC
    ''');

    return [
      for (final {
            "id": id as int,
            "roadmapName": roadmapName as String,
            "idRoadmapElement": idRoadmapElement as int?,
            "roadmapElement": roadmapElement as String?,
            "description": description as String?,
            "isCompleted": isCompleted as int,
          } in maps)
        CustomRoadmapModel(
          id: id,
          roadmapName: roadmapName,
          idRoadmapElement: idRoadmapElement,
          roadmapElement: roadmapElement,
          description: description,
          isCompleted: isCompleted,
        )
    ];
  }

  Future<void> addNewRoadmap(
      String name, String roadmapElement, String description) async {
    final db = await database;

    await db.insert(
      _tableName,
      {
        "roadmapName": name,
        "idRoadmapElement": 1,
        "roadmapElement": roadmapElement,
        "description": description,
        "isCompleted": 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
