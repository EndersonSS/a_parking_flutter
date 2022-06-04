import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:a_parking_flutter/app/models/parking/external/adapter/car_entity_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap CarEntityAdapter', () {
    test(
        'should return CarEntity when map fields id, status and parkingSpacelk are not null',
        () {
      //Arrange
      final Map<String, dynamic> map = {
        'id': 1,
        'placa': 'PFT2323',
        'parking_space_lk': 2,
        'status': 1,
        'entrada': '2022-06-03 13:57:33.057',
        'saida': '2022-06-03 13:57:33.057',
      };

      //Act
      final result = CarEntityAdapter.fromMap(map: map);

      //Assert
      expect(result, isA<CarEntity>());
      expect(result.id, 1);
      expect(result.placa, 'PFT2323');
      expect(result.entrada, '2022-06-03 13:57:33.057');
      expect(result.saida, '2022-06-03 13:57:33.057');
      expect(result.parkingSpacelk, 2);
      expect(result.status, 1);
    });
  });
}
