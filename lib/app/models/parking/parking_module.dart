import 'package:a_parking_flutter/app/models/parking/domain/repositories/repositories.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/external/datasources/cart_datasource.dart';
import 'package:a_parking_flutter/app/models/parking/external/datasources/parking_space_datasource.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/car_datasource_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/parking_space_datasource_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/repositories/infra_repositories.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/pages/pages.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/db/db_off.dart';

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
        Bind.factory<IParkingSpaceUsecase>(
          (i) => ParkingSpaceUsecase(
            parkingSpaceRepository: i.get(),
          ),
        ),

        Bind.factory<ICarUsecase>(
          (i) => CarUsecase(
            carRepository: i.get(),
          ),
        ),

        //cubit
        Bind.factory(
          (i) => ParkingCubit(
            parkingSpaceUsecase: i.get(),
            carUsecase: i.get(),
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
