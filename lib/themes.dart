import 'package:flutter/material.dart';

const Color appbarColor = Color(0xff35605A);
const Color textColor = Colors.white;
const Color backgroundFilterColor = Color.fromARGB(175, 0, 0, 0);
const Color boxColor = Color.fromARGB(175, 107, 129, 140);
const Color checkboxCheckedColor = Color.fromARGB(200, 40, 196, 108);
const Color iconColor = Color.fromARGB(255, 40, 196, 108);
const Color errorColor = Color.fromARGB(255, 182, 87, 81);

const double fontsizeAppbar = 20;
const double sizeAppbar = 48;

const BorderRadius borderRadius = BorderRadius.all(Radius.circular(10));

ThemeData themeData = ThemeData(
    fontFamily: 'RobotoRegular',
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                width: 0, color: Color.fromARGB(200, 40, 196, 108)))));

Container backgroundImage() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/Backgroundimage.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container filterBackgroundImage() {
  return Container(decoration: BoxDecoration(color: backgroundFilterColor));
}
