import 'package:flutter/material.dart';
import 'navigation/app_routes.dart';
import 'navigation/router_generator.dart';
import 'utiles/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool loggedIn = await AuthPrefs.isLoggedIn();
  runApp(MyApp(initialRoute: loggedIn ? AppRoutes.news : AppRoutes.login));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karims News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
