import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';
import 'package:a_parking_flutter/app/models/parking/domain/repositories/repositories.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';



void main() {
  late ICarRepository carRepository;
  late CarUsecase carUsecase;

  setUp(() {
    carRepository = CarRepositoryMock();
    carUsecase = CarUsecase(carRepository: carRepository);
  });

  group('CarUsecase', () {
    test('should return List<ProfileEntity> when call to repository succeeds',
        () async {
      when(() => carRepository.getCar(
              finalDate: '2022-06-03 13:57:33.057',
              initialDate: '2022-05-03 13:57:33.057'))
          .thenAnswer((_) async => <CarEntity>[]);

      //Act
      final result = await carUsecase.call(
          finalDate: '2022-06-03 13:57:33.057',
          initialDate: '2022-05-03 13:57:33.057');

      //Assert
      expect(result, isA<List<CarEntity>>());
      verify(() => carRepository.getCar(
          finalDate: '2022-06-03 13:57:33.057',
          initialDate: '2022-05-03 13:57:33.057')).called(1);
      verifyNoMoreInteractions(carRepository);
    });

    test('should not return error when saving car', () async {
      when(() => carRepository.saveCar(idCar: 1, placa: 'Tpj2132',idParkingSpace:  2))
          .thenAnswer((_) async => null);

      //Act
      final result = await carUsecase.saveCar(idCar: 1, placa: 'Tpj2132',idParkingSpace:  2);

      //Assert
      expect(result, null);
      verify(() => carRepository.saveCar(idCar: 1, placa: 'Tpj2132', idParkingSpace: 2)).called(1);
      verifyNoMoreInteractions(carRepository);
    });

    test('should throw FailureOnEmptyDates when dates isEmpty', () async {
      //Assert
      expect(() async => await carUsecase.call(finalDate: '', initialDate: ''),
          throwsA(isA<FailureParamEmpty>()));
    });

    test('should throw FailureOnEmptyDates when placa isEmpty', () async {
      //Assert
      expect(() async => await carUsecase.saveCar(idCar: 1,placa:  '',idParkingSpace:  2),
          throwsA(isA<FailureParamEmpty>()));
    });
  });
}
