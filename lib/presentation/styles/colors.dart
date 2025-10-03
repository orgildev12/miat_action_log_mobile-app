import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0C4DA2);
const Color gradientStart = Color(0xFF1463CA);
const Color gradientEnd = Color(0xFF3A8DFF);
const Color backgroundColor = Color(0xFFF3F2F8);
const Color black = Color(0xFF292D32);
const Color white = Color(0xFFFFFFFF);
const Color hintText = Color(0xFF4C5868);
const Color danger = Color(0xFFA10D00);
const Color warning = Color(0xFFDE8405);
const Color success= Color(0xFF16AC25);

const LinearGradient mainGradient = LinearGradient(
  colors: [gradientStart, gradientEnd],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);