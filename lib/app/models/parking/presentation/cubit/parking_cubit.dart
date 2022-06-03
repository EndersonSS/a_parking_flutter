import 'package:a_parking_flutter/app/models/parking/presentation/cubit/events.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/states.dart';
import 'package:bloc/bloc.dart';

import '../../domain/errors/failures.dart';
import '../../domain/usecases/get_car.dart';
import '../../domain/usecases/get_parking_space.dart';

class ParkingCubit extends Bloc<ParkingEvent, ParkingState> {
  ParkingCubit({
    required IGetCarUsecase getCarUsecase,
    required IGetParkingSpaceUsecase getParkingSpaceUsecase,
  })  : _getParkingSpaceUsecase = getParkingSpaceUsecase,
        _getCarUsecase = getCarUsecase,
        super(ParkingInitialState()) {
    on<GetParkingEvent>(
      (event, emit) => getParkingSpace(event, emit),
    );

    on<InitParkingEvent>(
      (event, emit) => emit(ParkingInitialState()),
    );

    on<SaveCarEvent>(
      (event, emit) => saveCar(event, emit),
    );

    on<GetReportCarEvent>(
      (event, emit) => getReportCar(event, emit),
    );
  }

  final IGetCarUsecase _getCarUsecase;
  final IGetParkingSpaceUsecase _getParkingSpaceUsecase;

  DateTime _dateInitialController =
      DateTime.now().subtract(const Duration(days: 1));

  DateTime get dateInitialController => _dateInitialController;

  DateTime _dateFinalController = DateTime.now();

  DateTime get dateFinalController => _dateFinalController;

  Future<void> getParkingSpace(
    GetParkingEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      emit(ParkingLoadingState());
      final result =
          await _getParkingSpaceUsecase.call(searchText: event.searchText);
      if (result.isEmpty) {
        emit(ParkingEmptyState());
      } else {
        emit(ParkingLoadedState(parking: result));
      }
    } on ParkingFailure catch (error) {
      emit(ParkingErrorState(errorMessage: error.message));
    }
  }

  saveCar(
    SaveCarEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      await _getCarUsecase.saveCar(
          event.idCar, event.placa, event.idParkingSpac);
      emit(CarSucessState());
      emit(ParkingInitialState());
    } catch (error) {
      emit(CarErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> getReportCar(
    GetReportCarEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      emit(ParkingLoadingState());
      final result = await _getCarUsecase.call(
          initialDate: event.initialDate, finalDate: event.finalDate);
      if (result.isEmpty) {
        emit(CarEmptyState());
      } else {
        emit(CarLoadedState(car: result));
      }
    } on ParkingFailure catch (error) {
      emit(ParkingErrorState(errorMessage: error.message));
    }
  }

  void dateInitial(DateTime event) {
    _dateInitialController = event;
  }

  void dateFinal(DateTime event) {
    _dateFinalController = event;
  }
}
