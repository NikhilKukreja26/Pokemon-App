import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        return ThemeData(
          primarySwatch: Colors.red,
          brightness: brightness == Brightness.light
              ? Brightness.light
              : Brightness.dark,
          scaffoldBackgroundColor: brightness == Brightness.dark
              ? Colors.blueGrey[900]
              : Colors.white,
        );
      },
      themedWidgetBuilder: (BuildContext context, ThemeData themeData) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          title: 'Pokemon App',
          home: SplashScreen(),
        );
      },
    );
  }
}
