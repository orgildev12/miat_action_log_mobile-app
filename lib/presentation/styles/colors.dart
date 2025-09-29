import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0C4DA2);
const Color gradientStart = Color(0xFF1463CA);
const Color gradientEnd = Color(0xFF3A8DFF);
const Color backgroundColor = Color(0xFFF6F6F6);
const Color black = Color(0xFF292D32);
const Color white = Color(0xFFFFFFFF);

const LinearGradient mainGradient = LinearGradient(
  colors: [gradientStart, gradientEnd],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);