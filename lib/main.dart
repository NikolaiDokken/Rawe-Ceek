import 'package:flutter/material.dart';
import 'package:rawe_ceek/driver_constructor_provider.dart';
import 'package:provider/provider.dart';
import 'package:rawe_ceek/home.dart';
import './services/splash_service.dart';

Future<void> main() async {
  final drivers = await getDrivers();
  final constructors = await getConstructors();
  var driverConstructorProvider = DriverConstructorProvider();
  driverConstructorProvider.setDriverList(drivers);
  driverConstructorProvider.setConstructorList(constructors);
  return runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => driverConstructorProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal[900],
        accentColor: Colors.teal,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.teal,
        ),
      ),
      home: Home(),
    ));
  }
}
