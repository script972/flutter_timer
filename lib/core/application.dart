import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/custom_route.dart';
import 'package:flutter_app/presentation/bloc/setup_bloc.dart';
import 'package:flutter_app/presentation/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Application extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  Application();

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    final theme = ThemeData(
      fontFamily: "GoogleSans",
      primaryColor: Color(0xFF02AD58),
      dividerColor: Colors.black,
    );

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(),
          ),
          BlocProvider<SetupBloc>(
            create: (context) => SetupBloc(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: !kReleaseMode,
            theme: theme,
            darkTheme: theme,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            onGenerateRoute: CustomRoute.generateRoute,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            initialRoute: CustomRoute.SETUP_SCREEN),
      ),
    );
  }
}
