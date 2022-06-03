import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:a_parking_flutter/app/models/parking/external/datasources/parking_space_datasource.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/exceptions.dart';
import '../../infra/datasources/car_datasource_interface.dart';
import '../adapter/car_entity_adapter.dart';

class CarDatasource implements ICarDatasource {
  final Database db;
  final ParkingSpaceDatasource parkingSpaceDatasource;
  CarDatasource(this.db, this.parkingSpaceDatasource);

  @override
  Future<List<CarEntity>> getCar(
      {required String initialDate, required String finalDate}) async {
    try {
      List<Map<String, dynamic>> resultado = await db.rawQuery(
          '''SELECT 
                id,
                placa,
                status,
                parking_space_lk,
                entrada,
                saida
              FROM
                a_car
              WHERE
                  status = 0 AND saida BETWEEN '$initialDate' and '$finalDate'; ''');

      List<CarEntity> lista = List.generate(
          resultado.length, (i) => CarEntityAdapter.fromMap(map: resultado[i]));

      return lista;
    } on DatabaseException catch (error, stackTrace) {
      throw NoInternetExpcetion(
        message: 'Error. Try Again',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future saveCar(int idCar, String placa, int idParkingSpace) async {
    try {
      await db.transaction((txn) async {
        var batch = txn.batch();

        if (idCar == 0) { 
          batch.insert(
            'a_car',
            {
              'parking_space_lk': idParkingSpace,
              'placa': placa.trim(),
              'status': 1,
              'entrada':
                  DateFormat('yyyy-MM-dd HH:mm:ss.mmm').format(DateTime.now()),
            },
          );
          batch.update(
            'a_parking_space',
            {
              'status': 0,
            },
            where: 'id = ?',
            whereArgs: [idParkingSpace],
          );
        } else { 
          batch.update(
            'a_car',
            {
              'status': 0,
              'saida':
                  DateFormat('yyyy-MM-dd HH:mm:ss.mmm').format(DateTime.now()),
            },
            where: 'id = ?',
            whereArgs: [idCar],
          );
          batch.update(
            'a_parking_space',
            {
              'status': 1,
            },
            where: 'id = ?',
            whereArgs: [idParkingSpace],
          );
        }

        await batch.commit();
        return;
      });
    } on DatabaseException catch (error, stackTrace) {
      throw NoInternetExpcetion(
        message: 'Error. Try Again',
        stackTrace: stackTrace,
      );
    }
  }
}
