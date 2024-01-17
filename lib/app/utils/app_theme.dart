import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

var appTheme = ThemeData(
    primaryColor: white,
    scaffoldBackgroundColor: white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: buttonBackground)),
    appBarTheme: AppBarTheme(
        backgroundColor: white,
        iconTheme: const IconThemeData(color: black),
        titleTextStyle: GoogleFonts.roboto(color: black, fontSize: 18)),
    iconTheme: const IconThemeData(
      color: black,
    ));
