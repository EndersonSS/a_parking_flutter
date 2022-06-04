import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';

import '../entities/car_entity.dart';
import '../repositories/car_repository_interface.dart';

abstract class ICarUsecase {
  Future<List<CarEntity>> call(
      {required String initialDate, required String finalDate});

  Future saveCar(
      {required int idCar, required String placa, required int idParkingSpace});
}

class CarUsecase implements ICarUsecase {
  final ICarRepository _carRepository;

  CarUsecase({
    required ICarRepository carRepository,
  }) : _carRepository = carRepository;

  @override
  Future<List<CarEntity>> call(
      {required String initialDate, required String finalDate}) async {
    final bool dateInitial = initialDate.isEmpty;
    final bool dateFinal = finalDate.isEmpty;

    if (dateInitial || dateFinal) {
      throw FailureParamEmpty(
        message: 'Please dates cannot be empty.',
      );
    }
    return await _carRepository.getCar(
        finalDate: finalDate, initialDate: initialDate);
  }

  @override
  Future saveCar(
      {required int idCar,
      required String placa,
      required int idParkingSpace}) async {
    final bool isPlaca = placa.isEmpty;

    if (isPlaca) {
      throw FailureParamEmpty(
        message: 'Please dates cannot be empty.',
      );
    }

    return await _carRepository.saveCar(
        idCar: idCar, placa: placa, idParkingSpace: idParkingSpace);
  }
}
