import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';

abstract class ICarRepository {
  Future<List<CarEntity>> getCar({
    required String initialDate,
    required String finalDate,
  });

  Future saveCar(
      {required int idCar, required String placa, required int idParkingSpace});
}
