import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/widgets/widgets.dart';
import 'package:a_parking_flutter/app/utils/string_resources.dart';
import 'package:a_parking_flutter/app/utils/time_diference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportsPage extends StatelessWidget {
  final ParkingCubit parkingCubit;

  const ReportsPage({Key? key, required this.parkingCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
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
      appBar: const PAppbar(
        backgroundColor: Colors.white,
        title: StringResources.report,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              DateTimeButton(
                editingController: editingDateInitialController,
                title: StringResources.dateInitial,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    initialDate: parkingCubit.dateInitialController,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (dt != null && dt != DateTime.now()) {
                    parkingCubit.dateInitial(dt);
                    editingDateInitialController.text =
                        DateFormat('dd/MM/y').format(dt).toString();
                  }
                },
              ),
              const SizedBox(width: 10),
              DateTimeButton(
                editingController: editingDateFinalController,
                title: StringResources.dateFinal,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    initialDate: parkingCubit.dateFinalController,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (dt != null && dt != DateTime.now()) {
                    parkingCubit.dateFinal(dt);
                    editingDateFinalController.text =
                        DateFormat('dd/MM/y').format(dt).toString();
                  }
                },
              ),
              const SizedBox(width: 30),
              OutlinedButtonParking(
                title: StringResources.filter,
                backgroundColor: Colors.blue,
                onPressed: () {
                  parkingCubit.add(GetReportCarEvent(
                      initialDate: DateFormat('y-MM-dd HH:mm:ss.mmm')
                          .format(parkingCubit.dateInitialController)
                          .toString(),
                      finalDate: DateFormat('y-MM-dd HH:mm:ss.mmm')
                          .format(parkingCubit.dateFinalController)));
                },
              )
            ],
          ),
          BlocConsumer<ParkingCubit, ParkingState>(
            bloc: parkingCubit,
            listener: (context, state) {},
            buildWhen: (oldState, newState) {
              return oldState != newState;
            },
            builder: (context, state) {
              if (state is CarInitialState) {
                return const SizedBox.shrink();
              }
              if (state is CarErrorState) {
                return Center(
                    child:
                        Text('${StringResources.error} ${state.errorMessage}'));
              }
              if (state is CarLoadingState) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is CarEmptyState) {
                return const Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Center(child: Text(StringResources.notFound)));
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
                                      ? '${StringResources.car}: ${parking.placa}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? '${StringResources.entry}: ${dateFormat.format(DateTime.parse(parking.entrada))}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? '${StringResources.exit}: ${dateFormat.format(DateTime.parse(parking.saida))}'
                                      : ''),
                                  Text(parking.status == 0
                                      ? '${StringResources.lenghtOfStay}:  ${TimeDiference.calculateTimeDifferenceBetween(startDate: DateTime.parse(parking.entrada), endDate: DateTime.parse(parking.saida))}'
                                      : ''),
                                ],
                              ),
                              leading: const Icon(Icons.check),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Text(
                        'Total: ${state.car.length} veiculos',
                        style: const TextStyle(fontSize: 17),
                      ),
                    )
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
