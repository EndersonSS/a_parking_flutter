import 'package:a_parking_flutter/app/models/parking/presentation/cubit/parking_cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/pages/parking_page.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/pages/reports.page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/db/db_off.dart';
import 'domain/repositories/car_repository_interface.dart';
import 'domain/repositories/parking_space_repository_interface.dart';
import 'domain/usecases/get_car.dart';
import 'domain/usecases/get_parking_space.dart';
import 'external/datasources/cart_datasource.dart';
import 'external/datasources/parking_space_datasource.dart';
import 'infra/datasources/car_datasource_interface.dart';
import 'infra/datasources/parking_space_datasource_interface.dart';
import 'infra/repositories/car_repository.dart';
import 'infra/repositories/parking_space_repository.dart';

class ParkingModule extends Module {
  @override
  List<Bind> get binds => [
        // datasource
        Bind.lazySingleton<IParkingSpaceDatasource>(
          (i) => ParkingSpaceDatasource(
            DbOff().db,
          ),
        ),

        Bind.lazySingleton<ICarDatasource>(
          (i) => CarDatasource(
            DbOff().db,
            i.get(),
          ),
        ),

        //repository
        Bind.lazySingleton<IParkingSpaceRepository>(
          (i) => ParkingSpaceRepository(
            parkingSpaceDatasource: i.get(),
          ),
        ),

        Bind.lazySingleton<ICarRepository>(
          (i) => CarRepository(
            carDatasource: i.get(),
          ),
        ),

        //usecase
        Bind.factory<IGetParkingSpaceUsecase>(
          (i) => GetParkingSpaceUsecase(
            parkingSpaceRepository: i.get(),
          ),
        ),

        Bind.factory<IGetCarUsecase>(
          (i) => GetCarUsecase(
            carRepository: i.get(),
          ),
        ),

        //cubit
        Bind.factory(
          (i) => ParkingCubit(
            getParkingSpaceUsecase: i.get(),
            getCarUsecase: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ParkingPage(
            parkingCubit: Modular.get<ParkingCubit>(),
          ),
        ),
        ChildRoute(
          '/reports',
          child: (context, args) => ReportsPage(
            parkingCubit: Modular.get<ParkingCubit>(),
          ),
        ),
      ];
}
