import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';

abstract class IParkingSpaceRepository {
  Future<List<ParkingSpaceEntity>> getParkingSpace();

  Future updateParkingSpace({required int id, required int satatus});

  Future<bool> insertParkingSpace({required String vacancyNumber});

  Future deleteParkingSpace({required int id});
}
