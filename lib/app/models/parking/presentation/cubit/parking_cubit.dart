import 'package:a_parking_flutter/app/models/parking/domain/errors/failures.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/car_usecase.dart';
import 'package:a_parking_flutter/app/models/parking/domain/usecases/parking_space_usecase.dart';
import 'package:bloc/bloc.dart';

import 'cubit.dart';

class ParkingCubit extends Bloc<ParkingEvent, ParkingState> {
  ParkingCubit({
    required ICarUsecase carUsecase,
    required IParkingSpaceUsecase parkingSpaceUsecase,
  })  : _parkingSpaceUsecase = parkingSpaceUsecase,
        _carUsecase = carUsecase,
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

    on<InsertParkingEvent>(
      (event, emit) => insertParkingSpace(event, emit),
    );

    on<DeleteParkingEvent>(
      (event, emit) => deleteParkingSpace(event, emit),
    );
  }

  final ICarUsecase _carUsecase;
  final IParkingSpaceUsecase _parkingSpaceUsecase;

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
      final result = await _parkingSpaceUsecase.call();
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
      await _carUsecase.saveCar(
          idCar: event.idCar,
          placa: event.placa,
          idParkingSpace: event.idParkingSpace);
      emit(ParkingInitialState());
    } catch (error) {
      emit(ParkingErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> getReportCar(
    GetReportCarEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      if (event.initialDate.isEmpty || event.finalDate.isEmpty) {
        emit(
          const CarErrorState(
            errorMessage: 'Please dates cannot be empty.',
          ),
        );
        return;
      }
      emit(CarLoadingState());
      final result = await _carUsecase.call(
          initialDate: event.initialDate, finalDate: event.finalDate);
      if (result.isEmpty) {
        emit(CarEmptyState());
      } else {
        emit(CarLoadedState(car: result));
      }
    } on ParkingFailure catch (error) {
      emit(CarErrorState(errorMessage: error.message));
    }
  }

  Future<void> insertParkingSpace(
    InsertParkingEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      final result = await _parkingSpaceUsecase.insertParkingSpace(
          vacancyNumber: event.vacancyNumber);

      if (result == true) {
      } else {
        emit(const ParkingExistingState(
            errorMessage: 'Vaga já existente, digite outro numero disponivel'));
      }
    } catch (error) {
      emit(ParkingErrorState(errorMessage: error.toString()));
    }

    emit(ParkingInitialState());
  }

  Future deleteParkingSpace(
    DeleteParkingEvent event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      await _parkingSpaceUsecase.deleteParkingSpace(id: event.id);
    } catch (error) {
      emit(ParkingErrorDeleteState(errorMessage: error.toString()));
    }

    emit(ParkingInitialState());
  }

  void dateInitial(DateTime event) {
    _dateInitialController = event;
  }

  void dateFinal(DateTime event) {
    _dateFinalController = event;
  }


  @override
  Future<void> close() {
    return super.close();
  }
}
