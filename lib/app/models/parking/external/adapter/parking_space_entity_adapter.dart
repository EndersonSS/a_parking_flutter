import 'package:a_parking_flutter/app/models/parking/domain/entities/parking_space_entity.dart';
import 'package:intl/intl.dart';

class ParkingSpaceEntityAdapter {
  static ParkingSpaceEntity fromMap({required Map<String, dynamic> map}) {
    return ParkingSpaceEntity(
      id: map['id'] as int,
      status: map['status'] as int,
      vaga: map['vaga'].toString(),
      carFk: map['car_fk'] ?? 0,
      veiculo: map['veiculo'] ?? '',
      entrada: map['entrada'] == null
          ? ''
          : DateFormat('dd/MM/y HH:mm').format(DateTime.parse(map['entrada'])),
      saida: map['saida'] == null
          ? ''
          : DateFormat('dd/MM/y HH:mm').format(DateTime.parse(map['saida'])),
    );
  }
}
