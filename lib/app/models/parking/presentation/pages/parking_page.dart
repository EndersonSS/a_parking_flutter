import 'package:a_parking_flutter/app/core/widgets/p_app_bar.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/cubit/cubit.dart';
import 'package:a_parking_flutter/app/models/parking/presentation/widgets/widgets.dart';
import 'package:a_parking_flutter/app/utils/string_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParkingPage extends StatelessWidget {
  final ParkingCubit parkingCubit;

  const ParkingPage({Key? key, required this.parkingCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TextEditingController editingController =
        TextEditingController(text: '');

    late final TextEditingController addParkingSpaceController =
        TextEditingController(text: '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PAppbar(
        backgroundColor: Colors.white,
        title: StringResources.parkingLots,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                MenuBottomTop(
                  onPressed1: () {
                    addParkingSpaceController.clear();
                    showAlertInputDialog(
                      context,
                      entrada: true,
                      textInputType: TextInputType.number,
                      title: StringResources.addNewVacancy,
                      message: StringResources.vacancyNumber,
                      defaultAction1: StringResources.cancel,
                      defaultAction2: StringResources.save,
                      controller: addParkingSpaceController,
                      onClickOk: () => {
                        parkingCubit.add(InsertParkingEvent(
                            vacancyNumber: addParkingSpaceController.text)),
                      },
                    );
                  },
                  onPressed2: (() => Modular.to.pushNamed('/reports')),
                ),
                BlocConsumer<ParkingCubit, ParkingState>(
                    bloc: parkingCubit,
                    listener: (context, state) {
                      if (state is ParkingExistingState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                          ),
                        );
                      }
                      if (state is ParkingErrorDeleteState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                          ),
                        );
                      }
                    },
                    buildWhen: (oldState, newState) {
                      return oldState != newState;
                    },
                    builder: (context, state) {
                      if (state is ParkingInitialState) {
                        parkingCubit.add(GetParkingEvent());
                        return const SizedBox.shrink();
                      }
                      if (state is ParkingErrorState) {
                        return Center(
                            child: Column(
                          children: [
                            const SizedBox(height: 220),
                            Text(
                                '${StringResources.error} ${state.errorMessage}'),
                            const SizedBox(height: 20),
                            OutlinedButtonParking(
                                onPressed: () {
                                  parkingCubit.add(GetParkingEvent());
                                },
                                backgroundColor: Colors.red,
                                title: StringResources.tryAgain)
                          ],
                        ));
                      }
                      if (state is ParkingLoadingState) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      if (state is ParkingEmptyState) {
                        return const Text(StringResources.noToRegistered);
                      }
                      if (state is ParkingLoadedState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 510.h,
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
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Vaga N° ${parking.vaga}',
                                                    style: const TextStyle(
                                                        fontSize: 17)),
                                              ),
                                              DescriptionCar(
                                                entryTime: parking.entrada,
                                                licensePlate: parking.veiculo,
                                                available: parking.status == 0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: OutlinedButtonParking(
                                                  backgroundColor: parking
                                                              .status ==
                                                          1
                                                      ? const Color.fromARGB(
                                                          255, 12, 130, 43)
                                                      : Colors.red,
                                                  title: parking.status == 1
                                                      ? StringResources.entry
                                                      : StringResources.exit,
                                                  onPressed: parking.status == 1
                                                      ? () async {
                                                          editingController
                                                              .clear();
                                                          await showAlertInputDialog(
                                                            context,
                                                            entrada: true,
                                                            textInputType:
                                                                TextInputType
                                                                    .text,
                                                            title:
                                                                StringResources
                                                                    .insertEntry,
                                                            message:
                                                                StringResources
                                                                    .informPlate,
                                                            defaultAction1:
                                                                StringResources
                                                                    .comeBack,
                                                            defaultAction2:
                                                                StringResources
                                                                    .entry,
                                                            controller:
                                                                editingController,
                                                            onClickOk: () => {
                                                              parkingCubit.add(
                                                                SaveCarEvent(
                                                                    placa:
                                                                        editingController
                                                                            .text,
                                                                    idParkingSpace:
                                                                        parking
                                                                            .id),
                                                              ),
                                                            },
                                                          );
                                                        }
                                                      : () => {
                                                            showAlertInputDialog(
                                                              context,
                                                              entrada: false,
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                              title: StringResources
                                                                  .registerDepartureTitle,
                                                              message:
                                                                  StringResources
                                                                      .registerDepartureSubTitle,
                                                              defaultAction1:
                                                                  StringResources
                                                                      .no,
                                                              defaultAction2:
                                                                  StringResources
                                                                      .yes,
                                                              controller:
                                                                  editingController,
                                                              onClickOk: () => {
                                                                parkingCubit
                                                                    .add(
                                                                  SaveCarEvent(
                                                                    idCar: parking
                                                                        .carFk,
                                                                    idParkingSpace:
                                                                        parking
                                                                            .id,
                                                                    placa: parking
                                                                        .veiculo,
                                                                  ),
                                                                ),
                                                              },
                                                            ),
                                                          },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        parking.status == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 8),
                                                child: CircleButton(
                                                  onPressed: () {
                                                    showAlertInputDialog(
                                                      context,
                                                      entrada: false,
                                                      textInputType:
                                                          TextInputType.number,
                                                      title: StringResources
                                                          .deleteTheParkingTitle,
                                                      message: StringResources
                                                          .deleteTheParkingSubtitle,
                                                      defaultAction1:
                                                          StringResources.no,
                                                      defaultAction2:
                                                          StringResources.yes,
                                                      controller:
                                                          editingController,
                                                      onClickOk: () => {
                                                        parkingCubit.add(
                                                          DeleteParkingEvent(
                                                              id: parking.id),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 0,
                                                width: 0,
                                              ),
                                      ],
                                    );
                                  },
                                ),
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
        ),
      ),
    );
  }
}
