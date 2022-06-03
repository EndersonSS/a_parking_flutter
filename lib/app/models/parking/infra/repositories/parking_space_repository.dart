import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';

import '../../domain/errors/failures.dart';
import '../../domain/repositories/parking_space_repository_interface.dart';
import '../datasources/parking_space_datasource_interface.dart';

class ParkingSpaceRepository implements IParkingSpaceRepository {
  final IParkingSpaceDatasource _parkingSpaceDatasource;

  ParkingSpaceRepository({
    required IParkingSpaceDatasource parkingSpaceDatasource,
  }) : _parkingSpaceDatasource = parkingSpaceDatasource;

  @override
  Future<List<ParkingSpaceEntity>> getParkingSpace(
      {required String searchText}) async {
    try {
      return await _parkingSpaceDatasource.getParkingSpace(
          searchText: searchText);
    } catch (error, stackTrace) {
      throw ParkingUnknownFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label: 'ParkingUnknownFailure: getParkingSpace() - ParkingUnknownFailure');
    }
  }

  @override
  Future updateParkingSpace(int id, int satatus) async {
    try {
      return await _parkingSpaceDatasource.updateParkingSpace(id, satatus);
    } catch (error, stackTrace) {
      throw ParkingUnknownFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label: 'ParkingUnknownFailure: updateParkingSpace() - ParkingUnknownFailure');
    }
  }
  
 
}
