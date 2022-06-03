import '../entities/car_entity.dart';

abstract class ICarRepository {
  Future<List<CarEntity>> getCar({
    required String initialDate,
    required String finalDate,
  });

  Future saveCar(int idCar, String placa, int idParkingSpac);
}
