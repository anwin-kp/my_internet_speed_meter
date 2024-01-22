import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const homeScreenText = 'Home Screen';
  static const checkSpeedText = 'Check Internet Speed';

  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueGrey.shade400,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    elevation: 10,
    shadowColor: Colors.blueAccent,
  );
}
