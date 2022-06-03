class DbAParkingSpace {
  static const sql = [
    '''
        CREATE TABLE IF NOT EXISTS a_parking_space(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          status INTEGER DEFAULT 1,
          vaga VARCHAR(100) NOT NULL
        );        
    ''',
    //insert
    '''INSERT INTO a_parking_space (vaga) VALUES ('01');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('02');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('03');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('04');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('05');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('06');''',
    '''INSERT INTO a_parking_space (vaga) VALUES ('07');''',
  ];
}
