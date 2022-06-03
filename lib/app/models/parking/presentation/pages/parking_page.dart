import 'package:a_parking_flutter/app/models/parking/domain/entities/car_entity.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/events.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/states.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/widgets/description_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/parking_cubit.dart';
import '../widgets/menu_bottom_sheet.dart';
import '../widgets/outlined_button_parking.dart';
import '../widgets/show_alert_input_dialog.dart';

class ParkingPage extends StatelessWidget {
  final ParkingCubit parkingCubit;

  const ParkingPage({Key? key, required this.parkingCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TextEditingController editingController =
        TextEditingController(text: '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Vagas de Estacionamento',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            BlocBuilder<ParkingCubit, ParkingState>(
                bloc: parkingCubit,
                buildWhen: (oldState, newState) {
                  return oldState != newState;
                },
                builder: (context, state) {
                  if (state is ParkingInitialState) {
                    parkingCubit.add(GetParkingEvent(searchText: ''));
                    return const SizedBox.shrink();
                  }
                  if (state is ParkingErrorState) {
                    return const Center(child: Text('Error...'));
                  }
                  if (state is ParkingLoadingState) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  if (state is ParkingEmptyState) {
                    return const Text('Não a vagas cadastradas.');
                  }
                  if (state is ParkingLoadedState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 600,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 2.3 / 3.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: state.parking.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final parking = state.parking[index];
                                return Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Vaga ${parking.vaga}',
                                            style:
                                                const TextStyle(fontSize: 17)),
                                      ),
                                      DescriptionCar(
                                        entryTime: parking.entrada,
                                        licensePlate: parking.veiculo,
                                        available: parking.status == 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OutlinedButtonParking(
                                          backgroundColor: parking.status == 1
                                              ? const Color.fromARGB(
                                                  255, 12, 130, 43)
                                              : Colors.red,
                                          title: parking.status == 1
                                              ? 'Entrada'
                                              : 'Saida',
                                          onPressed: parking.status == 1
                                              ? () async {
                                                  editingController.clear();
                                                  await showAlertInputDialog(
                                                    context,
                                                    entrada: true,
                                                    title: 'Inserir entrada',
                                                    message:
                                                        'Informe a placa do veiculo',
                                                    defaultAction1: 'Voltar',
                                                    defaultAction2: 'Entrada',
                                                    controller:
                                                        editingController,
                                                    onClickOk: () => {
                                                      parkingCubit.add(
                                                        SaveCarEvent(
                                                            placa:
                                                                editingController
                                                                    .text,
                                                            idParkingSpac:
                                                                parking.id),
                                                      ),
                                                    },
                                                  );
                                                }
                                              : () => {
                                                    showAlertInputDialog(
                                                      context,
                                                      entrada: false,
                                                      title: 'Registrar saida',
                                                      message:
                                                          'Deseja registrar a saida do veiculo ?',
                                                      defaultAction1: 'Não',
                                                      defaultAction2: 'Sim',
                                                      controller:
                                                          editingController,
                                                      onClickOk: () => {
                                                        parkingCubit.add(
                                                          SaveCarEvent(
                                                              idCar:
                                                                  parking.carFk,
                                                              idParkingSpac:
                                                                  parking.id),
                                                        ),
                                                      },
                                                    ),
                                                  },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        MenuBottomSheet(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButtonParking(
                                    title: 'Adicionar Vaga',
                                    backgroundColor: Colors.blue,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButtonParking(
                                    title: 'Relatorio',
                                    backgroundColor: Colors.blue,
                                    onPressed: (() =>
                                        Modular.to.pushNamed('/reports')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
