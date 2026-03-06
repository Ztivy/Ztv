import 'package:flutter/material.dart';
import 'package:ztv/screens/dashboard_screen.dart';
import 'package:ztv/screens/list_cast_screen.dart';
import 'package:ztv/screens/login_screen.dart';
import 'package:ztv/listeners/value_listener.dart';
import 'package:ztv/utils/theme_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDarkMode,
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          routes: {
            "/dash" : (context) => DashboardScreen() ,
            "/cast": (context) => ListCastScreen()
          },
          theme: value ? ThemeApp.WarmTheme() : ThemeData.light(),
        );
      }
    );
  }
}