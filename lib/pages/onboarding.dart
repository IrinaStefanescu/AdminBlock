import 'package:admin_block/components/onboarding_component.dart';
import 'package:admin_block/pages/service/register.dart';
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
  void dispose() {
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'lib/assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              OnboardingComponent(
                title: 'Control and manage your \n housekeeping online.',
                image: 'lib/assets/images/onboarding-icon-one.png',
              ),
              SizedBox(
                height: 20,
              ),
              OnboardingComponent(
                title: 'Download images on your \nlocal storage.',
                image: 'lib/assets/images/onboarding-icon-two.png',
              ),
              SizedBox(
                height: 20,
              ),
              OnboardingComponent(
                title: 'Receive notifications when\ncompleting an action.',
                image: 'lib/assets/images/onboarding-icon-three.png',
              ),
              SizedBox(
                height: 20,
              ),
              OnboardingComponent(
                title: 'Complaints about neighbours.',
                image: 'lib/assets/images/onboarding-icon-four.png',
              ),
              SizedBox(
                height: 20,
              ),
              OnboardingComponent(
                title: 'All from your mobile device.',
                image: 'lib/assets/images/onboarding-icon-five.png',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 105.0),
                child: Container(
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
                            'lib/assets/images/arrow_right.png',
                            width: 27,
                            height: 27,
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
              ),
              Row(
                children: [
                  Image.asset(
                    'lib/assets/images/custom_elipses.png',
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
