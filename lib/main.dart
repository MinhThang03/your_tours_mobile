import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/routes.dart';
import 'package:your_tours_mobile/screens/splash/splash_screen.dart';
import 'package:your_tours_mobile/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
