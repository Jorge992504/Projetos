import 'package:flusql/app/models/db_lite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static final DbService _dbService = DbService._internal();
  factory DbService() => _dbService;
  DbService._internal();

  Database? _database;

  Future<Database> get dataBase async {
    _database ??= await _iniDB();
    return _database!;
  }

  Future<Database> _iniDB() async {
    final path = join(await getDatabasesPath(), 'offline_data.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE data(id integer primary key AUTOINCREMENT, text TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(DbLite data) async {
    final dbClient = await dataBase;
    await dbClient.insert('data', data.toMap());
  }

  Future<List<DbLite>> getALLData() async {
    final dbCLient = await dataBase;
    final List<Map<String, dynamic>> maps = await dbCLient.query('data');
    return List.generate(maps.length, (i) => DbLite.fromMap(maps[i]));
  }

  Future<void> deleteData(int id) async {
    final dbCLient = await dataBase;
    await dbCLient.delete('data', where: 'id = ?', whereArgs: [id]);
  }
}
