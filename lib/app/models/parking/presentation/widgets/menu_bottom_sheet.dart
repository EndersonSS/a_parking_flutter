import 'package:a_parking_flutter/app/models/parking/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet(
      {Key? key, required this.onPressed1, required this.onPressed2})
      : super(key: key);

  final void Function() onPressed1;
  final void Function() onPressed2;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButtonParking(
                  title: 'Adicionar Vaga',
                  backgroundColor: Colors.blue,
                  onPressed: onPressed1),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButtonParking(
                title: 'Relatorio',
                backgroundColor: Colors.blue,
                onPressed: onPressed2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
