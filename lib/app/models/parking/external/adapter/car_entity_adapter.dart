import 'package:a_parking_flutter/app/models/parking/domain/entities/entities.dart';
import 'package:intl/intl.dart';

class CarEntityAdapter {
  static CarEntity fromMap({required Map<String, dynamic> map}) {
    return CarEntity(
      id: map['id'],
      placa: map['placa'],
      parkingSpacelk: map['parking_space_lk'],
      status: map['status'],
      entrada: map['entrada'] == null
          ? ''
          : DateFormat('y-MM-dd HH:mm:ss.mmm')
              .format(DateTime.parse(map['entrada'])),
      saida: map['saida'] == null
          ? ''
          : DateFormat('y-MM-dd HH:mm:ss.mmm')
              .format(DateTime.parse(map['saida'])),
    );
  }
}
