import 'package:sqflite/sqflite.dart';

mockDatabase(Database db) async {
  await db.execute(
    '''
      CREATE TABLE IF NOT EXISTS a_car(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          parking_space_lk INTEGER, 
          placa VARCHAR(100) NOT NULL, 
          status INTEGER(1) DEFAULT 1 /*'0=suspenso,1=ativo'*/,
          entrada DEFAULT CURRENT_TIMESTAMP,
          saida DEFAULT CURRENT_TIMESTAMP
        );       
    ''',
  );
  await db.insert('a_car', <String, Object?>{
    'parking_space_lk': 1,
    'placa': 'test',
    'entrada': '2022-06-04 18:08:37',
    'saida': '2022-06-04 18:08:37'
  });

  await db.execute(
    '''
      CREATE TABLE IF NOT EXISTS a_parking_space(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          status INTEGER DEFAULT 1,
          vaga VARCHAR(100) NOT NULL
        );        
    ''',
  );

  await db.insert('a_parking_space', <String, Object?>{
    'status': 1,
    'vaga': 'test',
  });
}
