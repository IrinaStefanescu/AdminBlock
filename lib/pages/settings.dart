import 'package:admin_block/pages/user_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserMain()));
                }
            ),
            Text(
              "Settings",
              style: GoogleFonts.mukta(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 100,),
            Card(
              margin: EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'About',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.policy,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Privacy Policy',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.assignment,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Terms and Conditions',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              margin: EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.support,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Support',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.feedback_outlined,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Provide feedback',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.report_problem_rounded,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Report abuse',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              margin: EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Delete your account',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.orange[600],
                      ),
                      label: Text(
                        'Log out',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () async {
                      },
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
