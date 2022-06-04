import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.yellow,
        child: InkWell(
          splashColor: Colors.red,
          onTap: onPressed,
          child: const SizedBox(
              width: 25,
              height: 25,
              child: Icon(
                Icons.clear_outlined,
              )),
        ),
      ),
    );
  }
}
