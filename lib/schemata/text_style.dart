import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get bold => weight(FontWeight.w600);

  // Styles
  TextStyle get medium20 => customStyle(
        fontSize: 20,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );
  TextStyle get normal10 => customStyle(
        fontSize: 10,
        letterSpacing: 0.0,
        weight: FontWeight.w300,
      );
  TextStyle get normal12 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w300,
      );
  TextStyle get medium12 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );
  TextStyle get medium10 => customStyle(
        fontSize: 10,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );
  TextStyle get normal16 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.normal,
      );
  TextStyle get medium16 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );
  TextStyle get bold16 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.bold,
      );
  TextStyle get normal14 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.normal,
      );
  TextStyle get medium14 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get semibold16 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );
  TextStyle get normal18 => customStyle(
        fontSize: 18,
        letterSpacing: 0.0,
        weight: FontWeight.normal,
      );
  TextStyle get medium19 => customStyle(
        fontSize: 19,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );
  TextStyle get bold20 => customStyle(
        fontSize: 20,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );
  TextStyle get semibold24 => customStyle(
        fontSize: 23,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );
  TextStyle get errorText12 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.normal,
      );

  /// Shortcut for color
  TextStyle textColor(Color v) => copyWith(color: v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  /// Shortcut for fontSize
  TextStyle size(double v) => copyWith(fontSize: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle customStyle({
    required double letterSpacing,
    required double fontSize,
    required FontWeight weight,
  }) =>
      copyWith(
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: weight,
      );
}
