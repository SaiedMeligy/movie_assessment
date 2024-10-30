import 'package:flutter/material.dart';
import 'package:movie_assessment/core/config/app_theme_manager.dart';
import 'package:movie_assessment/features/PopularPerson/page/popularperson_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Assessment',
      theme: AppThemeManager.lightTheme,
      home:const PopularPersonPage(),
      navigatorKey: navigatorKey,

    );
  }
}


