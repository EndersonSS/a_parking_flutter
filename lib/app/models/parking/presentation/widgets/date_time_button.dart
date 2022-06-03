import 'package:a_parking_flutter/app/models/parking/presentation/cubit/events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 

class DateTimeButton extends StatelessWidget {
  const DateTimeButton(
      {Key? key,
      required this.editingController,
      required this.title, required this.onTap, })
      : super(key: key);

  final TextEditingController editingController;
  final String title; 
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: MediaQuery.of(context).size.width * 0.29,
      child: TextField(
        readOnly: true,
        controller: editingController,
        onTap: onTap,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          labelText: title,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
