import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';
import 'package:a_parking_flutter/app/models/parking/domain/repositories/parking_space_repository_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/parking_space_datasource_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/repositories/parking_space_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late IParkingSpaceDatasource parkingSpaceDatasource;
  late IParkingSpaceRepository parkingSpaceRepository;

  setUp(() {
    parkingSpaceDatasource = ParkingSpaceDatasourceMock();
    parkingSpaceRepository = ParkingSpaceRepository(parkingSpaceDatasource: parkingSpaceDatasource);
  });

  group('getParkingSpace infra', () {
    test('should return List<ParkingSpaceEntity> when call to datasource is sucessful',
        () async {
      //Arrange
      when(() => parkingSpaceDatasource.getParkingSpace()).thenAnswer(
        (_) async => <ParkingSpaceEntity>[],
      );

      //Act
      final result = await parkingSpaceRepository.getParkingSpace();

      //Assert
      expect(result, isA<List<ParkingSpaceEntity>>());
      verify(() => parkingSpaceDatasource.getParkingSpace())
          .called(1);
      verifyNoMoreInteractions(parkingSpaceDatasource);
    });

    test(
        'should throw ProfileUnknownFailure when datasource throws a Expcetion',
        () async {
      //Arrange
      when(() => parkingSpaceDatasource.getParkingSpace()).thenThrow(Exception());

      //Assert
      expect(
          () async =>
              await parkingSpaceRepository.getParkingSpace(),
          throwsA(isA<ParkingUnknownFailure>()));
      verify(() => parkingSpaceDatasource.getParkingSpace())
          .called(1);
      verifyNoMoreInteractions(parkingSpaceDatasource);
    });
  });
}
