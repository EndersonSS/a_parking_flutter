import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';

abstract class IParkingSpaceRepository {
  Future<List<ParkingSpaceEntity>> getParkingSpace(
      {required String searchText});
   

  Future updateParkingSpace(int id, int satatus);
}
