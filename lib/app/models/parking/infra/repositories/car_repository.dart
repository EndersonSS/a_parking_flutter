import '../../domain/entities/car_entity.dart';
import '../../domain/errors/failures.dart';
import '../../domain/repositories/car_repository_interface.dart';
import '../datasources/car_datasource_interface.dart';

class CarRepository implements ICarRepository {
  final ICarDatasource _carDatasource;

  CarRepository({
    required ICarDatasource carDatasource,
  }) : _carDatasource = carDatasource;

  @override
  Future<List<CarEntity>> getCar({
    required String initialDate,
    required String finalDate,
  }) async {
    try {
      return await _carDatasource.getCar(
          initialDate: initialDate, finalDate: finalDate);
    } catch (error, stackTrace) {
      throw ParkingUnknownFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label: 'ParkingUnknownFailure: getCar() - ParkingUnknownFailure');
    }
  }

  @override
  Future saveCar(int idCar, String placa, int idParkingSpac) async {
    try {
      return await _carDatasource.saveCar(idCar, placa, idParkingSpac);
    } catch (error, stackTrace) {
      throw ParkingUnknownFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label:
              'ParkingUnknownFailure: updateParkingSpace() - ParkingUnknownFailure');
    }
  }
}
