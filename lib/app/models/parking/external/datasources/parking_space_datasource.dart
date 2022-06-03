import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';
import 'package:a_parking_flutter/app/models/parking/external/adapter/parking_space_entity_adapter.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/exceptions.dart';
import '../../infra/datasources/parking_space_datasource_interface.dart';

class ParkingSpaceDatasource implements IParkingSpaceDatasource {
  final Database db;
  ParkingSpaceDatasource(this.db);

  @override
  Future<List<ParkingSpaceEntity>> getParkingSpace(
      {required String searchText}) async {
    try {
      List<Map<String, dynamic>> resultado = await db.rawQuery(
          '''SELECT
                a_parking_space.id,
                a_parking_space.status,
                a_parking_space.vaga,
                a_car.id as car_fk,
                a_car.placa as veiculo,
                a_car.entrada as entrada,
                a_car.saida as saida
              FROM
                a_parking_space
              LEFT JOIN
                a_car ON a_parking_space.id = a_car.parking_space_lk AND a_car.status = 1;''');

      List<ParkingSpaceEntity> lista = List.generate(resultado.length,
          (i) => ParkingSpaceEntityAdapter.fromMap(map: resultado[i]));

      return lista;
    } on DatabaseException catch (error, stackTrace) {
      throw NoInternetExpcetion(
        message: 'Error. Try Again',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future updateParkingSpace(int id, int status) async {
    try {
      return await db.update(
        'a_parking_space',
        {
          'status': status,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (error, stackTrace) {
      throw NoInternetExpcetion(
        message: 'Error. Try Again',
        stackTrace: stackTrace,
      );
    }
  }

  // @override
  // Future insertParkingSpace(String numeroVaga) async {
  //   return await db.insert(
  //     'a_parking_space',
  //     {
  //       'vaaga': numeroVaga,
  //     },
  //   );
  // }
}
