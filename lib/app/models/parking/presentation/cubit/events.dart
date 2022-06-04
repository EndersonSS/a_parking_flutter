abstract class ParkingEvent {}

class GetParkingEvent implements ParkingEvent { 

  GetParkingEvent();
}

class GetReportCarEvent implements ParkingEvent {
  final String initialDate;
  final String finalDate;

  GetReportCarEvent({required this.finalDate, required this.initialDate});
}

class InitParkingEvent implements ParkingEvent {
   

  InitParkingEvent();
}

class SaveCarEvent implements ParkingEvent {
  final int idCar;
  final String placa;
  final int idParkingSpace;

  SaveCarEvent({
    this.idCar = 0,
    required this.placa,
    required this.idParkingSpace,
  });
}

class InsertParkingEvent implements ParkingEvent {
  final String vacancyNumber;

  InsertParkingEvent({
    required this.vacancyNumber,
  });
}

class DeleteParkingEvent implements ParkingEvent {
  final int id;

  DeleteParkingEvent({
    required this.id,
  });
}
