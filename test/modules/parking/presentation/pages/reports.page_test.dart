import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/pages/pages.dart';
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

  group('/reports', () {
    Future<void> initPage({
      required WidgetTester tester,
    }) async {
      await tester.pumpWidgetWithApp(
        MaterialApp(home: ReportsPage(parkingCubit: parkingCubit)),
      );
    }

    testWidgets('Should build without exploding', (tester) async {
      when(() => carUsecaseMock.call(initialDate: '', finalDate: ''))
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
      await initPage(tester: tester);

      expect(find.byType(ReportsPage), findsOneWidget);
    });
  });
}
