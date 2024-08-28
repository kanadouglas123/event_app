import 'package:flutter/material.dart';
ThemeData LightMode=ThemeData(
  brightness: Brightness.light,
  colorScheme:  ColorScheme.light(
    primary: Colors.black87,
    secondary: Colors.white,
      background: Colors.red.shade900

  )
);
ThemeData DarkMode=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.black87,
      secondary: Colors.white,
    background: Colors.red.shade900
  )

);