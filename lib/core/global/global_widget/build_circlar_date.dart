import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildCircularDayDecoration(int day, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
      "$day",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
