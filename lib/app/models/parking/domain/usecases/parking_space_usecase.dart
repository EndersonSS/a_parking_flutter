import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';
import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';

import '../repositories/parking_space_repository_interface.dart';

abstract class IParkingSpaceUsecase {
  Future<List<ParkingSpaceEntity>> call();

  Future<bool> insertParkingSpace({required String vacancyNumber});

  Future deleteParkingSpace({required int id});
}

class ParkingSpaceUsecase implements IParkingSpaceUsecase {
  final IParkingSpaceRepository _parkingSpaceRepository;

  ParkingSpaceUsecase({
    required IParkingSpaceRepository parkingSpaceRepository,
  }) : _parkingSpaceRepository = parkingSpaceRepository;

  @override
  Future<List<ParkingSpaceEntity>> call() async {
    return await _parkingSpaceRepository.getParkingSpace();
  }

  @override
  Future<bool> insertParkingSpace({required String vacancyNumber}) async {
    final bool isPlaca = vacancyNumber.isEmpty;

    if (isPlaca) {
      throw FailureParamEmpty(
        message: 'Please dates cannot be empty.',
      );
    }
    return await _parkingSpaceRepository.insertParkingSpace(
        vacancyNumber: vacancyNumber);
  }

  @override
  Future deleteParkingSpace({required int id}) async {
    final bool isParkingSpace = id == 0;

    if (isParkingSpace) {
      throw FailureParamEmpty(
        message: 'Please dates cannot be empty.',
      );
    }
    return await _parkingSpaceRepository.deleteParkingSpace(id: id);
  }
}
