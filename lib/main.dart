import 'package:flutter/material.dart';
import 'package:flutter_app/core/application.dart';
import 'package:flutter_app/presentation/bloc/simple_bloc_deletage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'ru',
      basePath: 'assets/i18n/',
      supportedLocales: [
        'en',
        'ru',
      ]);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(LocalizedApp(delegate, Application()));
}
