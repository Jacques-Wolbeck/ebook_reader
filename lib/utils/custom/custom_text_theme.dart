import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme extends TextTheme {
  CustomTextTheme()
      : super(
          displayLarge: GoogleFonts.poppins(fontSize: 57.0),
          displayMedium: GoogleFonts.poppins(fontSize: 45.0),
          displaySmall: GoogleFonts.poppins(fontSize: 36.0),
          headlineLarge: GoogleFonts.poppins(fontSize: 32.0),
          headlineMedium: GoogleFonts.poppins(fontSize: 28.0),
          headlineSmall: GoogleFonts.poppins(fontSize: 24.0),
          titleLarge: GoogleFonts.poppins(fontSize: 22.0),
          titleMedium: GoogleFonts.poppins(fontSize: 16.0, letterSpacing: .15),
          titleSmall: GoogleFonts.poppins(fontSize: 14.0, letterSpacing: .1),
          labelLarge: GoogleFonts.poppins(fontSize: 14.0, letterSpacing: .1),
          labelMedium: GoogleFonts.poppins(fontSize: 12.0, letterSpacing: .5),
          labelSmall: GoogleFonts.poppins(fontSize: 11.0, letterSpacing: .5),
          bodyLarge: GoogleFonts.poppins(fontSize: 16.0, letterSpacing: .15),
          bodyMedium: GoogleFonts.poppins(fontSize: 14.0, letterSpacing: .25),
          bodySmall: GoogleFonts.poppins(fontSize: 12.0, letterSpacing: .4),
        );
}
