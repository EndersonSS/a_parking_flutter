import '../entities/car_entity.dart';
import '../repositories/car_repository_interface.dart';

abstract class IGetCarUsecase {
  Future<List<CarEntity>> call(
      {required String initialDate, required String finalDate});
  Future saveCar(int idCar, String placa, int idParkingSpac);
}

class GetCarUsecase implements IGetCarUsecase {
  final ICarRepository _carRepository;

  GetCarUsecase({
    required ICarRepository carRepository,
  }) : _carRepository = carRepository;

  @override
  Future<List<CarEntity>> call(
      {required String initialDate, required String finalDate}) async {
    return await _carRepository.getCar(
        finalDate: finalDate, initialDate: initialDate);
  }

  @override
  Future saveCar(int idCar, String placa, int idParkingSpac) async {
    return await _carRepository.saveCar(idCar, placa, idParkingSpac);
  }
}
