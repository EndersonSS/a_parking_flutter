 

import '../../domain/entities/car_entity.dart';

abstract class ICarDatasource {
  Future<List<CarEntity>> getCar( {required String initialDate, required String finalDate, });

   Future saveCar(int idCar, String placa, int idParkingSpac);
}
