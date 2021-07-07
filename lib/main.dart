import 'package:flutter/material.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/launch_screen.dart';
import 'package:softag/screens/login_screen/login_screen.dart';
import 'package:softag/screens/main_screen/main_screen.dart';
import 'package:softag/screens/register_screen/register_screen.dart';

main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
        }),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.white,
          elevation: 0,
        ),
        primaryColor: defaultColor,
        primarySwatch: Colors.deepOrange,

        fontFamily: 'a',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/main_screen': (context) => MainScreen(),
      },
    );
  }
}
