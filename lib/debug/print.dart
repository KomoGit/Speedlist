import 'package:flutter/material.dart';

class Debug {
  static void printLog(dynamic message) {
    var currentTime = TimeOfDay.now();
    // ignore: avoid_print
    print("$currentTime - $message");
  }
}
