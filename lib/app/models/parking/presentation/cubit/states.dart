import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/parking_space_entity.dart';

abstract class ParkingState extends Equatable {}

class ParkingInitialState implements ParkingState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class ParkingLoadingState implements ParkingState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class ParkingLoadedState implements ParkingState {
  final List<ParkingSpaceEntity> parking;

  const ParkingLoadedState({required this.parking});

  @override
  List<Object?> get props => [parking];

  @override
  bool? get stringify => true;
}

class ParkingErrorState implements ParkingState {
  final String errorMessage;

  const ParkingErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class ParkingEmptyState implements ParkingState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CarErrorState implements ParkingState {
  final String errorMessage;

  const CarErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class CarSucessState implements ParkingState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CarLoadedState implements ParkingState {
  final List<CarEntity> car;

  const CarLoadedState({required this.car});

  @override
  List<Object?> get props => [car];

  @override
  bool? get stringify => true;
}

class CarEmptyState implements ParkingState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}