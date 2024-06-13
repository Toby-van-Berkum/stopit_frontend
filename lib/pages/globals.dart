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

class ScreenSizes {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class AppFonts {
  static final TextTheme poppins = GoogleFonts.poppinsTextTheme();
}

class AppTitle {
  static const String title = "Stop It";
}

class AppStyles {
  static InputDecoration inputStyle([String? hintText]) {
    return InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        filled: true,
        fillColor: AppColors.accentColor);
  }

  static TextStyle labelStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle headerStyle() {
    return const TextStyle(fontSize: 45);
  }

  static ButtonStyle largeButton(BuildContext context) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: Size(ScreenSizes.width(context), 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ));
  }
}

class SingleCard extends StatelessWidget {
  final String headText;
  final String statsText;
  final double widthCard;
  final Color colorCard;

  const SingleCard(
      {super.key,
      required this.headText,
      required this.statsText,
      required this.widthCard,
      required this.colorCard});

  @override
  Widget build(BuildContext context) {
    const double paddingCard = 18.0;

    return Container(
      width: widthCard,
      // height: 40,
      color: colorCard,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(paddingCard),
            alignment: Alignment.centerLeft,
            child: Text(
              headText,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(paddingCard),
            alignment: Alignment.centerRight,
            child: Text(statsText, textAlign: TextAlign.start),
          )
        ],
      ),
    );
  }
}

class CustomBoxHeights {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 48;

}

class LargeButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onPressed;

  const LargeButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          minimumSize: Size(ScreenSizes.width(context), 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Align(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              buttonLabel,
              style: const TextStyle(fontSize: 16), // Replace with your label style
            ),
          ),
        ),
      ),
    );
  }
}
