import 'package:intl/intl.dart';

import '../../domain/entities/car_entity.dart';

class CarEntityAdapter {
  static CarEntity fromMap({required Map<String, dynamic> map}) {
    return CarEntity(
      id: map['id'] as int,
      placa: map['placa'].toString(),
      parkingSpacelk: map['parking_space_lk'] as int,
      status: map['status'] as int,
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
