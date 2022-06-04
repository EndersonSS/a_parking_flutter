import 'package:flutter/material.dart';

Future<void> showAlertInputDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String defaultAction1,
  required String defaultAction2,
  required bool entrada,
  
  required TextInputType textInputType,
  required Function onClickOk,
  bool isDismissible = true,
  required TextEditingController controller,
}) async {
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (context) {
      return Form(
        key: form,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          titlePadding:
              const EdgeInsets.only(left: 20, top: 25, bottom: 15, right: 8),
          title: Row(
            children: [
              Text(
                title,
              ),
            ],
          ),
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 32),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
              ),
              entrada == true
                  ? TextFormField(
                      keyboardType: textInputType,
                      controller: controller,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Campo obrigatorio';
                        }
                        return null;
                      },
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text(
                    defaultAction1,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                entrada == true
                    ? TextButton(
                        child: Text(
                          defaultAction2,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          form.currentState!.validate();
                          if (controller.text.isNotEmpty) {
                            Navigator.pop(context);
                            onClickOk();
                          }
                        },
                      )
                    : TextButton(
                        child: Text(
                          defaultAction2,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onClickOk();
                        },
                      ),
              ],
            )
          ],
        ),
      );
    },
  );
}
