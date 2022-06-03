 
import 'package:a_parking_flutter/app/core/db/migarations/db_a_car.dart';
import 'package:a_parking_flutter/app/core/db/migarations/db_a_parking_space.dart'; 
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DbOff {
  static final DbOff _dbOff = DbOff._();

  DbOff._();

  late Database db;

  factory DbOff() {
    return _dbOff;
  }

  Future<void> initDB() async {
    String path = p.join(await getDatabasesPath(), 'aparking.db');
    //await deleteDatabase(path); //revisar se deixa esse delete
    db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
    print('========== rodando onCreate banco');
  }

  static Future _onConfigure(Database db) async {
    print('========== rodando configure');
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Código SQL para criar o banco de dados e a tabela
  static Future _onCreate(Database db, int version) async {
    print('========== rodando sql inicio');
    try {
      List<String> sqlTotal = [];
      sqlTotal.addAll(DbACar.sql);
      sqlTotal.addAll(DbAParkingSpace.sql);
      // ---------------------------------- 

      for (String v in sqlTotal) {
        await db.execute(v);
      }
    } catch (e) {
      print('========== erro sql inicio');
      print(e);
    }
    print('========== rodando sql fim');
  }
}
