// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:mobx/mobx.dart';

// import '../../domain/entities/car_entity.dart'; 
// import '../../domain/usecases/get_car.dart';
// part 'reports_store.g.dart';

// class ReportsStore = _ReportsStoreBase with _$ReportsStore;

// abstract class _ReportsStoreBase with Store {

//   final IGetCarUsecase iGetCarUsecase = Modular.get<IGetCarUsecase>();


//   @observable
//   ObservableStream<List<CarEntity>>? carList;


//   void saveCar(CarEntity carEntity, int idParkingSpac) async {
//       carList = await
//         iGetCarUsecase.saveCar(carEntity, idParkingSpac).asObservable();
//   }

//   void saveCar(CarEntity carEntity, int idParkingSpac) async {
//       carList = await
//         iGetCarUsecase.saveCar(carEntity, idParkingSpac).asObservable();
//   }

// }


 