import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';
import 'package:a_parking_flutter/app/models/parking/domain/repositories/car_repository_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/car_datasource_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/repositories/car_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';


void main() {
  late ICarDatasource carDatasource;
  late ICarRepository carRepository;

  setUp(() {
    carDatasource = CarDatasourceMock();
    carRepository = CarRepository(carDatasource: carDatasource);
  });

  group('getCar infra', () {
    test('should return List<CarEntity> when call to datasource is sucessful',
        () async {
      //Arrange
      when(() => carDatasource.getCar(
          initialDate: any(named: 'initialDate'),
          finalDate: any(named: 'finalDate'))).thenAnswer(
        (_) async => <CarEntity>[],
      );

      //Act
      final result = await carRepository.getCar(initialDate: '', finalDate: '');

      //Assert
      expect(result, isA<List<CarEntity>>());
      verify(() => carDatasource.getCar(initialDate: '', finalDate: ''))
          .called(1);
      verifyNoMoreInteractions(carDatasource);
    });

    test(
        'should throw ProfileUnknownFailure when datasource throws a Expcetion',
        () async {
      //Arrange
      when(() => carDatasource.getCar(
          initialDate: any(named: 'initialDate'),
          finalDate: any(named: 'finalDate'))).thenThrow(Exception());

      //Assert
      expect(
          () async =>
              await carRepository.getCar(initialDate: '', finalDate: ''),
          throwsA(isA<ParkingUnknownFailure>()));
      verify(() => carDatasource.getCar(initialDate: '', finalDate: ''))
          .called(1);
      verifyNoMoreInteractions(carDatasource);
    });
  });
}
