import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';
import 'package:a_parking_flutter/app/models/parking/domain/repositories/repositories.dart'; 
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late IParkingSpaceRepository parkingSpaceRepository;
  late ParkingSpaceUsecase parkingSpaceUsecase;

  setUp(() {
    parkingSpaceRepository = ParkingSpaceRepositoryMock();
    parkingSpaceUsecase = ParkingSpaceUsecase(parkingSpaceRepository:parkingSpaceRepository);
  });

  group('ParkingSapceUsecase', () {
    test('should return List<ParkingSpaceEntity> when call to repository succeeds',
        () async {
      when(() => parkingSpaceRepository.getParkingSpace())
          .thenAnswer((_) async => <ParkingSpaceEntity>[]);

      //Act
      final result = await parkingSpaceUsecase.call();

      //Assert
      expect(result, isA<List<ParkingSpaceEntity>>());
      verify(() => parkingSpaceRepository.getParkingSpace()).called(1);
      verifyNoMoreInteractions(parkingSpaceRepository);
    });

    test('should return true when call to repository succeeds', () async {
      when(() => parkingSpaceRepository.insertParkingSpace(vacancyNumber: '02'))
          .thenAnswer((_) async => true);

      //Act
      final result = await parkingSpaceUsecase.insertParkingSpace(vacancyNumber: '02');

      //Assert
      expect(result, true);
      verify(() => parkingSpaceRepository.insertParkingSpace(vacancyNumber: '02')).called(1);
      verifyNoMoreInteractions(parkingSpaceRepository);
    });

    test('should not return error when delete parking space', () async {
      when(() => parkingSpaceRepository.deleteParkingSpace(id: 1))
          .thenAnswer((_) async => null);

      //Act
      final result = await parkingSpaceUsecase.deleteParkingSpace(id: 1);

      //Assert
      expect(result, null);
      verify(() => parkingSpaceRepository.deleteParkingSpace(id: 1)).called(1);
      verifyNoMoreInteractions(parkingSpaceRepository);
    });

    test('should throw FailureParamEmpty when vacancyNumber isEmpty', () async {
      //Assert
      expect(() async => await parkingSpaceUsecase.insertParkingSpace(vacancyNumber: ''),
          throwsA(isA<FailureParamEmpty>()));
    });

    test('should throw FailureParamEmpty when id is 0', () async {
      //Assert
      expect(() async => await parkingSpaceUsecase.deleteParkingSpace(id: 0),
          throwsA(isA<FailureParamEmpty>()));
    });
  });
}
