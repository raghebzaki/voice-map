import 'package:flutter_map/Database/PlaceList.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{

  Future<Database> database() async{
    return openDatabase(
      join(await getDatabasesPath(), 'places_db.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE places(id INTEGER PRIMARY KEY, name TEXT, Lat DOUBLE, Lng DOUBLE)",
        );
      },
      version: 1,
    );
  }

  Future<void> insert(PlaceList placeList) async {
    final Database db = await database();
    await db.insert(
      placeList.table(),
      placeList.tomap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(PlaceList placeList) async {
    final Database db = await database();
    await db.update(
      placeList.table(),
      placeList.tomap(),
      where: "name = ?",
      whereArgs: [placeList.getname()],
    );
  }

  Future<void> delete(PlaceList placeList) async {
    final Database db = await database();
    await db.delete(
      placeList.table(),
        where: "name = ?",
        whereArgs: [placeList.getname()],
    );
  }

  Future<List<PlaceList>> getAll() async {
    final Database db = await database();
    final List<Map<String, dynamic>> maps = await db.query('places');

    List<PlaceList> placeList = [];
    for(var item in maps){
      placeList.add(PlaceList.frommap(item));
    }
    return placeList;
  }
}