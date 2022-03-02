import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingComponent extends StatelessWidget {
  final String title;
  final String image;

  const OnboardingComponent({Key ? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 25,
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: GoogleFonts.inter(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
              //textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
