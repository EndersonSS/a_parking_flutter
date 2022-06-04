import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/external/datasources/parking_space_datasource.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/parking_space_datasource_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../mocks/mock_database.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  late IParkingSpaceDatasource parkingSpaceDatasource;

  setUp(() async {
    sqfliteTestInit();
  });

  group('ParkingSpaceDatasource', () {
    test(
        'should return List<ParkingSpaceEntity> when you find an empty or occupied vacancy',
        () async {
      var db = await openDatabase(inMemoryDatabasePath);
      await mockDatabase(db);
      parkingSpaceDatasource = ParkingSpaceDatasource(db);

      final result = await parkingSpaceDatasource.getParkingSpace();

      expect(result, isA<List<ParkingSpaceEntity>>());
      await db.close();
    });
  });
}
