
import 'package:flutter/material.dart';
import 'package:pizza/Styles.dart';

import 'Config.dart';
import 'screens/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test home',
      theme: ThemeData(
        primarySwatch: MaterialColor(Config.primaryColor.value, {
          50:Config.primaryColor.withOpacity(.1),
          100:Config.primaryColor.withOpacity(.2),
          200:Config.primaryColor.withOpacity(.3),
          300:Config.primaryColor.withOpacity(.4),
          400:Config.primaryColor.withOpacity(.5),
          500:Config.primaryColor.withOpacity(.6),
          600:Config.primaryColor.withOpacity(.7),
          700:Config.primaryColor.withOpacity(.8),
          800:Config.primaryColor.withOpacity(.9),
          900:Config.primaryColor.withOpacity(1),
        }),

        fontFamily: 'SourceSansPro',
        shadowColor: Config.shadowColor,
        primaryColor: Config.primaryColor,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          titleTextStyle: Styles.titleBoldStyle,
          backgroundColor: Config.screenBackColor,
          iconTheme: IconThemeData(
            size: Config.iconSize, color: Colors.white,
          )
        ),
        iconTheme: IconThemeData(
          size: Config.iconSize,
        )
      ),
      home: const MainScreen(),
    );
  }
}
