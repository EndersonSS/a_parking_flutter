import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_test/flutter_test.dart';

MaterialApp materialTestApp(Widget widget,
    {String title = 'test', ThemeData? theme}) {
  return MaterialApp(
    title: title,
    theme: theme ?? ThemeData(primarySwatch: Colors.blue),
    home: widget,
  );
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithApp(Widget widget,
      {String title = 'test',
      ThemeData? theme,
      List<BlocProviderSingleChildWidget> providers =
          const <BlocProviderSingleChildWidget>[]}) async {
    if (providers.isNotEmpty) {
      await pumpWidget(MultiBlocProvider(
        providers: providers,
        child: materialTestApp(widget, title: title, theme: theme),
      ));
    } else {
      await pumpWidget(materialTestApp(widget, title: title, theme: theme));
    }
  }
}
