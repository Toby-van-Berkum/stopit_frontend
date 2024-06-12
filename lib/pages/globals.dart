// lib/colors.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFFB580);
  static const Color secondaryColor = Color(0xFFFFE8D6);
  static const Color accentColor = Color(0xFFF9F6F7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFFD6E9FF);
  static const Color green = Color(0xFFD7FFD6);
  static const Color yellow = Color(0xFFF3F4BC);
  static const Color black = Color(0xFF000000);

// Add more colors as needed
}

class AppFonts {
  static final TextTheme poppins = GoogleFonts.poppinsTextTheme();
}

class SingleCard extends StatelessWidget{
  final String headText;
  final String statsText;
  final double widthCard;
  final Color colorCard;

  const SingleCard(
      {super.key, required this.headText, required this.statsText,
        required this.widthCard, required this.colorCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthCard,
      // height: 40,
      color: colorCard,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(headText, textAlign: TextAlign.end),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(statsText, textAlign: TextAlign.start),
          )
        ],
      ),
    );
  }
}