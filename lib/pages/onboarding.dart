import 'package:admin_block/pages/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingUser extends StatefulWidget {
  OnBoardingUser({Key? key}) : super(key: key);

  @override
  _OnBoardingUserState createState() => _OnBoardingUserState();
}

class _OnBoardingUserState extends State<OnBoardingUser> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "WELCOME ONBOARD",
            style: GoogleFonts.mukta(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('lib/images/logo.png', width: 280, height: 260,),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/onboarding-icon-one.png',
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
                            text:
                            'Control and manage your \n housekeeping online.',
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/onboarding-icon-two.png',
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
                            text:
                            'Download and send archived \n documents with password.',
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/onboarding-icon-three.png',
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
                            text:
                            'Take pictures of your indexes.',
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/onboarding-icon-four.png',
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
                            text:
                            'Complaints about neighbours.',
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/onboarding-icon-five.png',
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
                            text:
                            'All from your mobile device.',
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
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.2,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[600],
                ),
                child: MaterialButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Image.asset(
                          'lib/images/arrow_right.png',
                          width: 27, height: 27,
                          color: Color(0xF5F3A866),
                        ),
                      ],
                     ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    }),
              ),
              Row(
                children: [
                  Image.asset(
                    'lib/images/custom_elipses.png',
                    width: 160,
                    height: 165,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
