class DbACar {
  static const sql = [
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
    //insert
    // '''INSERT INTO a_car (placa) VALUES ('012ddadq');''',
    // '''INSERT INTO a_car (placa) VALUES ('0ewe2weq');''',
    // '''INSERT INTO a_car (placa) VALUES ('1wd12131');''',
  ];
}
