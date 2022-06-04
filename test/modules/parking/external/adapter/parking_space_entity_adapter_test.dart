import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/external/adapter/parking_space_entity_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap ParkingSpaceEntityAdapter', () {
    test(
        'should return ParkingSpaceEntity when map fields id, status and vaga are not null',
        () {
      //Arrange
      final Map<String, dynamic> map = {
        'id': 1,
        'vaga': '01',
        'veiculo': 'PFT2323',
        'car_fk': 2,
        'status': 1,
        'entrada': '2022-06-03 13:57:33.057',
        'saida': '2022-06-03 13:57:33.057', 
      };

      //Act
      final result = ParkingSpaceEntityAdapter.fromMap(map: map);

      //Assert
      expect(result, isA<ParkingSpaceEntity>());
      expect(result.id, 1);
      expect(result.vaga, '01');
      expect(result.veiculo, 'PFT2323');
      expect(result.carFk, 2);
      expect(result.status, 1);
      expect(result.entrada, '03/06/2022 13:57');
      expect(result.saida, '03/06/2022 13:57');
    });
  });
}