import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';

class GmeetLink extends StatefulWidget {
  const GmeetLink({Key? key}) : super(key: key);

  @override
  _GmeetLinkState createState() => _GmeetLinkState();
}

class _GmeetLinkState extends State<GmeetLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                    ),
                    Text(
                      'Dashboard',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                'Meeting',
                style: GoogleFonts.inter(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Icon(
                    Icons.meeting_room_outlined,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      'This is the google meet link for the meeting scheduled on ',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      'After pressing the button you will be redirected to Google Play Store either to open the Gmeet app or to install it.',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  'Enter the following link:',
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                )),
            TextButton(
              onPressed: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.google.android.apps.meetings',
                  appStoreLink:
                      'https://play.google.com/store/apps/details?id=com.google.android.apps.meetings&hl=en&gl=US',
                  // openStore: false
                );
              },
              child: Text(
                'G-meet link',
                style: GoogleFonts.inter(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
