import 'package:a_parking_flutter/app/models/parking/domain/repositories/repositories.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/car_datasource_interface.dart';
import 'package:a_parking_flutter/app/models/parking/infra/datasources/parking_space_datasource_interface.dart';
import 'package:mocktail/mocktail.dart';

class ParkingSpaceUsecaseMock extends Mock implements IParkingSpaceUsecase {}

class CarUsecaseMock extends Mock implements ICarUsecase {}

class CarDatasourceMock extends Mock implements ICarDatasource {}

class ParkingSpaceDatasourceMock extends Mock implements IParkingSpaceDatasource {}

class CarRepositoryMock extends Mock implements ICarRepository {}

class ParkingSpaceRepositoryMock extends Mock implements IParkingSpaceRepository {}