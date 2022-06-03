import 'package:flutter/material.dart';

class DescriptionCar extends StatelessWidget {
  const DescriptionCar({
    Key? key,
    required this.entryTime,
    required this.licensePlate,
    required this.available,
  }) : super(key: key);

  final String entryTime;
  final String licensePlate;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return available == true
        ? Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage(
                        "assets/car_parking.png",
                      ),
                      height: 80,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Placa:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    licensePlate,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('Entrada:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    entryTime,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        : const Flexible(
            fit: FlexFit.tight,
            child: Center(
                child: Text(
              'Disponivel',
            )),
          );
  }
}
