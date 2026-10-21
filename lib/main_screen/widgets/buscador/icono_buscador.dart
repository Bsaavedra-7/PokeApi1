import 'package:flutter/material.dart';

Padding iconoBuscador() {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Image.asset(
      "assets/images/pokedex2.png",
      width: 30,
      height: 30,
      fit: BoxFit.contain,
    ),
  );
}