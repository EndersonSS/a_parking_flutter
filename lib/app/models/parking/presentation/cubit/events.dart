import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';

abstract class ParkingEvent {}

class GetParkingEvent implements ParkingEvent {
  final String searchText;

  GetParkingEvent({required this.searchText});
}

class GetReportCarEvent implements ParkingEvent {
  final String initialDate;
  final String finalDate;

  GetReportCarEvent({required this.finalDate, required this.initialDate});
}

class InitParkingEvent implements ParkingEvent {
  final String searchText;

  InitParkingEvent({required this.searchText});
}

class SaveCarEvent implements ParkingEvent {
  final int idCar;
  final String placa;
  final int idParkingSpac;

  SaveCarEvent(
    {this.idCar = 0,
    this.placa = '',
    required this.idParkingSpac,
  });
}
