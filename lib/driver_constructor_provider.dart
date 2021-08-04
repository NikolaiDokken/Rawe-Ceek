import 'package:flutter/material.dart';
import 'package:rawe_ceek/models/car_constructor.dart';
import './models/driver.dart';
import 'models/car_constructor.dart';

class DriverConstructorProvider extends ChangeNotifier {
  List<Driver> drivers = [];
  List<CarConstructor> constructors = [];

  void setDriverList(List<Driver> newDrivers) {
    drivers = newDrivers;
    notifyListeners();
  }

  void setConstructorList(List<CarConstructor> newConstructors) {
    constructors = newConstructors;
    notifyListeners();
  }

  List<Driver> getDrivers() {
    return drivers;
  }
}
