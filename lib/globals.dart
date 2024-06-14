// lib/colors.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopit_frontend/pages/checkin_page.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'package:stopit_frontend/pages/journal_page.dart';
import 'package:stopit_frontend/pages/profile_page.dart';

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

}

class SingleCardStats extends StatelessWidget {
  final String headText;
  final String statsText;
  final double widthCard;
  final Color colorCard;

  const SingleCardStats(
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorCard),

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

class SingleCardAchievementExplanation extends StatelessWidget {
  final String headText;
  final String statsText;
  final double widthCard;
  final bool achievementCompleted;

  const SingleCardAchievementExplanation(
      {super.key,
        required this.headText,
        required this.statsText,
        required this.widthCard,
        required this.achievementCompleted,
      });

  @override
  Widget build(BuildContext context) {
    const double paddingCard = 18.0;
    final Color colorCard = achievementCompleted ? AppColors.green : AppColors.yellow;

    return Container(
      width: widthCard,
      // height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorCard),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: paddingCard, left: paddingCard, right: paddingCard),
            alignment: Alignment.centerLeft,
            child: Text(
              headText,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(paddingCard),
            alignment: Alignment.centerLeft,
            child: Text(statsText, textAlign: TextAlign.start),
          )
        ],
      ),
    );
  }
}

class SingleCardAchievement extends StatelessWidget {
  final String headText;
  final double widthCard;
  final Color colorCard;

  const SingleCardAchievement(
      {super.key,
        required this.headText,
        required this.widthCard,
        required this.colorCard,
      });

  @override
  Widget build(BuildContext context) {
    const double paddingCard = 18.0;

    return Container(
      margin: const EdgeInsets.only(right: paddingCard),
      width: widthCard,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorCard),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: (ScreenSizes.width(context) / 8), horizontal: 0.0),
            alignment: Alignment.center,
            child: Text(
              headText,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSizedBox {
  static SizedBox small() {
    return const SizedBox(height: 8);
  }
  static SizedBox medium() {
    return const SizedBox(height: 16);
  }

  static SizedBox large() {
    return const SizedBox(height: 48);
  }

  //Add more sizes as needed
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
    return ElevatedButton(
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
            style: AppStyles.labelStyle() // Replace with your label style
          ),
        ),
      ),
    );
  }
}

const pages = [
  const DashboardPage(title: AppTitle.title),
  const JournalPage(title: AppTitle.title),
  const ProfilePage(title: AppTitle.title)
];

int currentPageIndex = 0;