import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/pages/parking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_material_app_tester.dart';
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

  group('/', () {
    Future<void> initPage({
      required WidgetTester tester,
    }) async {
      await tester.pumpWidgetWithApp(
        MaterialApp(home: ParkingPage(parkingCubit: parkingCubit)),
      );
    }

    testWidgets('Should build without exploding', (tester) async {
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
      await initPage(tester: tester);

      expect(find.byType(ParkingPage), findsOneWidget);
    });
  });
}
