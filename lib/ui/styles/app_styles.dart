import 'package:flutter/material.dart';

const Color kPrimaryColorlight = Color(0xffFAE2D4);
const Color kPrimaryColordark = Color(0xffE8941C);
const double smallFont = 12.0;
const double mediumFont = 16.0;
const double largeFont = 24.0;

const Color kBasefontColor = Colors.black;

const kGradientButtonColor = LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 193, 115, 70),
    Color.fromARGB(255, 196, 124, 24),
  ],
);

const kGradientbrown = LinearGradient(begin: Alignment.topCenter, colors: [
  Color.fromARGB(255, 193, 115, 70),
  Color(0xffE8941C),
  Color.fromARGB(255, 216, 175, 152),
]);

MaterialColor appcolor = MaterialColor(0xffE8941C, color);

Map<int, Color> color = const {
  50: Color.fromARGB(255, 216, 175, 152),
  100: Color.fromARGB(255, 216, 175, 152),
  200: Color.fromARGB(255, 216, 175, 152),
  300: Color.fromARGB(255, 216, 175, 152),
  400: Color(0xffE8941C),
  500: Color.fromARGB(255, 193, 115, 70),
  600: Color.fromARGB(255, 193, 115, 70),
  700: Color.fromARGB(255, 193, 115, 70),
  800: Color.fromARGB(255, 193, 115, 70),
  900: Color.fromARGB(255, 193, 115, 70),
};
