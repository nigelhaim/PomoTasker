//This is where you can find the styling of the text
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, [Color? color, FontWeight? fw]) {
  return GoogleFonts.montserrat(fontSize: 24, color: color, fontWeight: fw);
}
