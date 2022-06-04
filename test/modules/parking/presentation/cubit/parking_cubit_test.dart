import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late IParkingSpaceUsecase parkingSpaceUsecaseMock;
  late ICarUsecase carUsecaseMock;
  late ParkingCubit parkingCubit;

  setUp(() {
    parkingSpaceUsecaseMock = ParkingSpaceUsecaseMock();
    carUsecaseMock = CarUsecaseMock();
    parkingCubit = ParkingCubit(
        parkingSpaceUsecase: parkingSpaceUsecaseMock,
        carUsecase: carUsecaseMock);
  });

  group('parking', () {
    test(
      'should emit [ParkingLoadingState, ParkingLoadedState] when usecase returns a non empty list',
      () async {
        when(() => parkingSpaceUsecaseMock.call()).thenAnswer(
          (_) async => <ParkingSpaceEntity>[
            const ParkingSpaceEntity(
                id: 0,
                status: 0,
                vaga: 'teste',
                carFk: 0,
                entrada: '',
                saida: '',
                veiculo: '')
          ],
        );

        //Assert
        expectLater(
          parkingCubit.stream,
          emitsInOrder(
            [
              isA<ParkingLoadingState>(),
              isA<ParkingLoadedState>(),
            ],
          ),
        );

        //Act
        parkingCubit.add(GetParkingEvent());
      },
    );

    test(
      'should emit [CarLoadingState, CarLoadedState] when usecase returns a non empty list',
      () async {
        when(() => carUsecaseMock.call(initialDate: 'date', finalDate: 'date'))
            .thenAnswer(
          (_) async => <CarEntity>[
            CarEntity(
                id: 0,
                status: 0,
                parkingSpacelk: 0,
                placa: '',
                entrada: '',
                saida: '')
          ],
        );

        //Assert
        expectLater(
          parkingCubit.stream,
          emitsInOrder(
            [
              isA<CarLoadingState>(),
              isA<CarLoadedState>(),
            ],
          ),
        );

        //Act
        parkingCubit
            .add(GetReportCarEvent(initialDate: 'date', finalDate: 'date'));
      },
    );

    test(
      'should emit [ParkingLoadingState, ParkingEmptyState] when usecase returns an empty list',
      () async {
        when(() => parkingSpaceUsecaseMock.call()).thenAnswer(
          (_) async => <ParkingSpaceEntity>[],
        );

        //Assert
        expectLater(
          parkingCubit.stream,
          emitsInOrder(
            [
              isA<ParkingLoadingState>(),
              isA<ParkingEmptyState>(),
            ],
          ),
        );

        //Act
        parkingCubit.add(GetParkingEvent());
      },
    );

    test(
      'should emit [CarLoadingState, CarLoadedState] when usecase returns an empty list',
      () async {
        when(() => carUsecaseMock.call(initialDate: 'date', finalDate: 'date'))
            .thenAnswer(
          (_) async => <CarEntity>[],
        );

        //Assert
        expectLater(
          parkingCubit.stream,
          emitsInOrder(
            [
              isA<CarLoadingState>(),
              isA<CarEmptyState>(),
            ],
          ),
        );

        //Act
        parkingCubit
            .add(GetReportCarEvent(initialDate: 'date', finalDate: 'date'));
      },
    );

    test(
      'should emit [CarErrorState] when initialDate and  finalDate isEmpty',
      () async {
        //Assert
        expectLater(
          parkingCubit.stream,
          emitsInOrder(
            [
              isA<CarErrorState>(),
            ],
          ),
        );

        //Act
        parkingCubit.add(GetReportCarEvent(initialDate: '', finalDate: ''));
      },
    );
  });
}
