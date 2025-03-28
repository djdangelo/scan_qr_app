import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static SqliteService instance = SqliteService._internal();
  static Database? _database;

  SqliteService._internal();

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'db_qr_data.db'),
      onCreate: (database, version) async {
        await database.execute('''CREATE TABLE TBL_QR_DATA (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            VALUE DOUBLE NOT NULL,
            CREATE_AT DATETIME NOT NULL,
            STATUS BOOLEAN)''');
      },
      version: 1,
    );
  }
}
