import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';

abstract class IParkingSpaceDatasource {
  Future<List<ParkingSpaceEntity>> getParkingSpace();

  Future updateParkingSpace(int id, int satatus);

  Future<bool> insertParkingSpace(String vacancyNumber);

  Future deleteParkingSpace(int id);
}
