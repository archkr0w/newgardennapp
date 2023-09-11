import 'package:flutter/material.dart';

Widget buildGradientAppBar() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
            Color.fromARGB(255, 35, 104, 29),
            Color.fromARGB(255, 19, 53, 36),
          ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );
}