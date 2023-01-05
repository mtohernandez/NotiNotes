import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static const String notesTable = 'notes';
  static const String userTable = 'user';

  static const String notesArgs =
      '"id" TEXT PRIMARY KEY, "title" TEXT, "content" TEXT, "tags" TEXT, "dateCreated" TEXT, "reminder" TEXT, "colorBackground" TEXT, "imageFile" TEXT, "patternImage" TEXT, "todoList" TEXT';
  
  static const String userArgs =
      'id TEXT PRIMARY KEY, name TEXT, bornDate TEXT, profilePicture TEXT';


  // One of the problems I find here are that the Map<String, Object?> data
  // is not very clear. I would expect to see a Map<String, dynamic>

  static Future<sql.Database> databaseNotes() async {
    // Get a location using getDatabasesPath
    final dbPath = await sql.getDatabasesPath();

    // Open the database from the selected path
    return sql.openDatabase(
      path.join(dbPath, '$notesTable.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $notesTable($notesArgs)',
        );
      },
      version: 1,
    );
  }

  static Future<sql.Database> databaseUser() async {
    // Get a location using getDatabasesPath
    final dbPath = await sql.getDatabasesPath();

    // Open the database from the selected path
    return sql.openDatabase(
      path.join(dbPath, '$userTable.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $userTable($userArgs)',
        );
      },
      version: 1,
    );
  }



  // This method is used to insert data into the database
  static Future<void> insert(String table, Map<String, Object?> data, Future<sql.Database> database) async {
    final db = await database;
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Used to fetch the data from the database
  static Future<List<Map<String, dynamic>>> getData(String table, Future<sql.Database> database) async {
    final db = await database;
    return db.query(table);
  }

  // Update the data in the database
  static Future<void> update(String table, Map<String, Object?> data, Future<sql.Database> database) async {
    final db = await database;
    db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  // Delete the data from the database
  static Future<void> delete(String table, String id, Future<sql.Database> database) async {
    final db = await database;
    db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
