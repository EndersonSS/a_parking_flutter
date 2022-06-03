import 'package:a_parking_flutter/app/models/parking/presentation/cubit/events.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/parking_cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/widgets/date_time_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../utils/time_diference.dart';
import '../cubit/events.dart';
import '../cubit/states.dart';
import '../widgets/menu_bottom_sheet.dart';
import '../widgets/outlined_button_parking.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, required this.parkingCubit}) : super(key: key);

  final ParkingCubit parkingCubit;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    late final TextEditingController editingDateFinalController =
        TextEditingController(
            text: DateFormat('dd/MM/y').format(DateTime.now()).toString());

    late final TextEditingController editingDateInitialController =
        TextEditingController(
            text: DateFormat('dd/MM/y')
                .format(DateTime.now().subtract(const Duration(days: 1)))
                .toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Relatório',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              DateTimeButton(
                editingController: editingDateInitialController,
                title: 'Data Inicial',
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    initialDate: widget.parkingCubit.dateInitialController,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (dt != null && dt != DateTime.now()) {
                    widget.parkingCubit.dateInitial(dt);
                    editingDateInitialController.text =
                        DateFormat('dd/MM/y').format(dt).toString();
                  }
                },
              ),
              const SizedBox(width: 10),
              DateTimeButton(
                editingController: editingDateFinalController,
                title: 'Data Final',
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    initialDate: widget.parkingCubit.dateFinalController,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (dt != null && dt != DateTime.now()) {
                    widget.parkingCubit.dateFinal(dt);
                    editingDateFinalController.text =
                        DateFormat('dd/MM/y').format(dt).toString();
                  }
                },
              ),
              const SizedBox(width: 30),
              OutlinedButtonParking(
                title: 'Filtrar',
                backgroundColor: Colors.blue,
                onPressed: () {
                  widget.parkingCubit.add(GetReportCarEvent(
                      initialDate: DateFormat('y-MM-dd HH:mm:ss.mmm')
                          .format(widget.parkingCubit.dateInitialController)
                          .toString(),
                      finalDate: DateFormat('y-MM-dd HH:mm:ss.mmm')
                          .format(widget.parkingCubit.dateFinalController)));
                },
              )
            ],
          ),
          BlocBuilder<ParkingCubit, ParkingState>(
            bloc: widget.parkingCubit,
            buildWhen: (oldState, newState) {
              return oldState != newState;
            },
            builder: (context, state) {
              if (state is ParkingInitialState) {
                return const SizedBox.shrink();
              }
              if (state is ParkingErrorState) {
                return const Center(child: Text('Error...'));
              }
              if (state is ParkingLoadingState) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is CarEmptyState) {
                return const Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Center(child: Text('Ops! Nada encontrado')));
              }
              if (state is CarLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15),
                      child: SizedBox(
                        height: 543,
                        child: ListView.separated(
                          separatorBuilder: (_, index) =>
                              const SizedBox(height: 8),
                          itemCount: state.car.length,
                          itemBuilder: (_, index) {
                            final parking = state.car[index];
                            return ListTile(
                              title: const Text('Descrição'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(parking.status == 0
                                      ? 'Veiculo: ${parking.placa}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? 'Entrada: ${parking.entrada}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? 'Saida: ${parking.saida}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? 'Tempo de permanência:  ${TimeDiference.calculateTimeDifferenceBetween(startDate: DateTime.parse(parking.entrada), endDate: DateTime.parse(parking.saida))}'
                                      : ''),
                                ],
                              ),
                              leading: const Icon(Icons.check),
                            );
                          },
                        ),
                      ),
                    ),
                    MenuBottomSheet(
                        widget: Text('Total: ${state.car.length} veiculos')),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
