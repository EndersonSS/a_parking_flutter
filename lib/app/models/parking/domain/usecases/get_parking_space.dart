import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';

import '../repositories/parking_space_repository_interface.dart';

abstract class IGetParkingSpaceUsecase {
  Future<List<ParkingSpaceEntity>> call({required String searchText}); 
}

class GetParkingSpaceUsecase implements IGetParkingSpaceUsecase {
  final IParkingSpaceRepository _parkingSpaceRepository;

  GetParkingSpaceUsecase({
    required IParkingSpaceRepository parkingSpaceRepository,
  }) : _parkingSpaceRepository = parkingSpaceRepository;

  @override
  Future<List<ParkingSpaceEntity>> call({required String searchText}) async {
    return await _parkingSpaceRepository.getParkingSpace(
        searchText: searchText);
  }
 
}
