import 'package:flutter/material.dart';

class DebugOut {
  static void printLog(String message) {
    var currentTime = TimeOfDay.now();
    // ignore: avoid_print
    print("$currentTime - $message");
  }
}
