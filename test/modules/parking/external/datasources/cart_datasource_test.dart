import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:a_parking_flutter/app/models/parking/external/datasources/cart_datasource.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/car_datasource_interface.dart';
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
  late ICarDatasource carDatasource;

  setUp(() async {
    sqfliteTestInit();
  });

  group('CarDatasource', () {
    test('should return List<CarEntity> when parameters are valid', () async {
      var db = await openDatabase(inMemoryDatabasePath);
      await mockDatabase(db);
      carDatasource = CarDatasource(db);

      final result = await carDatasource.getCar(
          finalDate: '2022-06-04 18:08:37', initialDate: '2022-05-04 18:08:37');

      expect(result, isA<List<CarEntity>>());
      await db.close();
    });
  });
}
