import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/db/db_off.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbOff().initDB();

  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Parking Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
