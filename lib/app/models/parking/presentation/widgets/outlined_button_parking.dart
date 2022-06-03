import 'package:flutter/material.dart';

class OutlinedButtonParking extends StatelessWidget {
  const OutlinedButtonParking(
      {Key? key,
      required this.onPressed,
      required this.backgroundColor,
      required this.title})
      : super(key: key);

  final void Function() onPressed;
  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.transparent),
          backgroundColor: backgroundColor,
          primary: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17),
        ));
  }
}
