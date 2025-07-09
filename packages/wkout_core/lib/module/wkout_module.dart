import 'package:flutter/material.dart';

abstract class WkoutModule<T> {
  Future<void> registerInjection();
  void unregisterInjections();
  void unload();

  String get name => T.toString();

  Future<void> loadFakeModule()async{}

}