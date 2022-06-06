import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/pages/service/validators.dart';
import 'package:admin_block/pages/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProvideFeedback extends StatefulWidget {
  const ProvideFeedback({Key? key}) : super(key: key);

  @override
  _ProvideFeedbackState createState() => _ProvideFeedbackState();
}

enum experienceRate { veryBad, bad, ok, good, veryGood }

enum bugsAndIssues { disagree, neither, agree }

enum wouldRecommendApp {
  stronglyDisagree,
  disagree,
  neither,
  agree,
  stronglyAgree
}

class _ProvideFeedbackState extends State<ProvideFeedback> {
  var email = "";
  var feedback = "";

  final _provideFeedbackFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  experienceRate? _expRate = experienceRate.veryBad;
  bugsAndIssues? _bugsIssues = bugsAndIssues.disagree;
  wouldRecommendApp? _wouldRecommend = wouldRecommendApp.stronglyDisagree;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  CollectionReference provided_feedback =
      FirebaseFirestore.instance.collection('provided_feedback_form');
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                }),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Provide feedback',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _provideFeedbackFormKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                offset: Offset(0, 5))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Text(
                    'Mobile App Feedback',
                    style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 35, top: 10, bottom: 40, right: 40),
                  child: Text(
                    'How was your experience using the new AdminBlock App? Please complete this form and let us know how our mobile app is doing and how we can make it better.',
                    style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Email',
                          style: GoogleFonts.inter(
                            color: Colors.grey[900],
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      fillColor: Color(0x70E0E0E0),
                      filled: true,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2)),
                      labelText: 'example@gmail.com',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16.0,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: UserInputValidator.validatedUserEmail,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 10, 20, 0),
                      child: RichText(
                        text: TextSpan(
                          text: 'How was your experience using the app?',
                          style: GoogleFonts.inter(
                            color: Colors.grey[900],
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(-16, 0),
                        child: ListTile(
                            title: Transform.translate(
                                offset: Offset(-15, 0),
                                child: Text('1 - my experience was very bad')),
                            leading: Radio<experienceRate>(
                              activeColor: Colors.orange,
                              value: experienceRate.veryBad,
                              groupValue: _expRate,
                              onChanged: (experienceRate? value) {
                                setState(() {
                                  _expRate = value!;
                                });
                              },
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(-16, -20),
                        child: ListTile(
                            title: Transform.translate(
                                offset: Offset(-15, 0),
                                child: Text('2 - my experience was bad')),
                            leading: Radio<experienceRate>(
                              activeColor: Colors.orange,
                              value: experienceRate.bad,
                              groupValue: _expRate,
                              onChanged: (experienceRate? value) {
                                setState(() {
                                  _expRate = value!;
                                });
                              },
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(-16, -40),
                        child: ListTile(
                            title: Transform.translate(
                                offset: Offset(-15, 0),
                                child: Text('3 - my experience was ok')),
                            leading: Radio<experienceRate>(
                              activeColor: Colors.orange,
                              value: experienceRate.ok,
                              groupValue: _expRate,
                              onChanged: (experienceRate? value) {
                                setState(() {
                                  _expRate = value!;
                                });
                              },
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(-16, -60),
                        child: ListTile(
                            title: Transform.translate(
                                offset: Offset(-15, 0),
                                child: Text('4 - my experience was good')),
                            leading: Radio<experienceRate>(
                              activeColor: Colors.orange,
                              value: experienceRate.good,
                              groupValue: _expRate,
                              onChanged: (experienceRate? value) {
                                setState(() {
                                  _expRate = value!;
                                });
                              },
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(-16, -80),
                        child: ListTile(
                            title: Transform.translate(
                                offset: Offset(-15, 0),
                                child: Text('5 - my experience was very good')),
                            leading: Radio<experienceRate>(
                              activeColor: Colors.orange,
                              value: experienceRate.veryGood,
                              groupValue: _expRate,
                              onChanged: (experienceRate? value) {
                                setState(() {
                                  _expRate = value!;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -70),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 10, 0),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'My experience was this way because:',
                            style: GoogleFonts.inter(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: GoogleFonts.inter(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -60),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      controller: _bodyController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        fillColor: Color(0x70E0E0E0),
                        filled: true,
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        errorStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16.0,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      onChanged: (value) {
                        feedback = value;
                      },
                      validator: UserInputValidator.validateUserAddressFields,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -40),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 20, 0),
                        child: RichText(
                          text: TextSpan(
                            text: 'I encountered bugs and issues: ',
                            style: GoogleFonts.inter(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: GoogleFonts.inter(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -40),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: Offset(-16, 0),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Disagree')),
                              leading: Radio<bugsAndIssues>(
                                activeColor: Colors.orange,
                                value: bugsAndIssues.disagree,
                                groupValue: _bugsIssues,
                                onChanged: (bugsAndIssues? value) {
                                  setState(() {
                                    _bugsIssues = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -20),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Neither disagree or agree')),
                              leading: Radio<bugsAndIssues>(
                                activeColor: Colors.orange,
                                value: bugsAndIssues.neither,
                                groupValue: _bugsIssues,
                                onChanged: (bugsAndIssues? value) {
                                  setState(() {
                                    _bugsIssues = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -40),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0), child: Text('Agree')),
                              leading: Radio<bugsAndIssues>(
                                activeColor: Colors.orange,
                                value: bugsAndIssues.agree,
                                groupValue: _bugsIssues,
                                onChanged: (bugsAndIssues? value) {
                                  setState(() {
                                    _bugsIssues = value!;
                                  });
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -70),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 20, 0),
                        child: RichText(
                          text: TextSpan(
                            text: 'I would recommend the app to others: ',
                            style: GoogleFonts.inter(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: GoogleFonts.inter(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -70),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: Offset(-16, 0),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Strongly disagree')),
                              leading: Radio<wouldRecommendApp>(
                                activeColor: Colors.orange,
                                value: wouldRecommendApp.stronglyDisagree,
                                groupValue: _wouldRecommend,
                                onChanged: (wouldRecommendApp? value) {
                                  setState(() {
                                    _wouldRecommend = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -20),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Disagree')),
                              leading: Radio<wouldRecommendApp>(
                                activeColor: Colors.orange,
                                value: wouldRecommendApp.disagree,
                                groupValue: _wouldRecommend,
                                onChanged: (wouldRecommendApp? value) {
                                  setState(() {
                                    _wouldRecommend = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -40),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Neither disagree or agree')),
                              leading: Radio<wouldRecommendApp>(
                                activeColor: Colors.orange,
                                value: wouldRecommendApp.neither,
                                groupValue: _wouldRecommend,
                                onChanged: (wouldRecommendApp? value) {
                                  setState(() {
                                    _wouldRecommend = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -60),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0), child: Text('Agree')),
                              leading: Radio<wouldRecommendApp>(
                                activeColor: Colors.orange,
                                value: wouldRecommendApp.agree,
                                groupValue: _wouldRecommend,
                                onChanged: (wouldRecommendApp? value) {
                                  setState(() {
                                    _wouldRecommend = value!;
                                  });
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: Offset(-16, -80),
                          child: ListTile(
                              title: Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text('Strongly Agree')),
                              leading: Radio<wouldRecommendApp>(
                                activeColor: Colors.orange,
                                value: wouldRecommendApp.stronglyAgree,
                                groupValue: _wouldRecommend,
                                onChanged: (wouldRecommendApp? value) {
                                  setState(() {
                                    _wouldRecommend = value!;
                                  });
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -130),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ButtonPrimary(
                        title: 'SUBMIT',
                        action: () async {
                          if (_provideFeedbackFormKey.currentState!
                              .validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Sending data...',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                            await provided_feedback
                                .doc(user!.uid)
                                .set({
                                  'email': _emailController.text,
                                  'rate_experience': _expRate.toString(),
                                  'feedback': _bodyController.text,
                                  'encountered_bugs': _bugsIssues.toString(),
                                  'would_recommend_app':
                                      _wouldRecommend.toString(),
                                })
                                .then((value) =>
                                    print("Feedback provided by user."))
                                .catchError((error) => print(
                                    'Failed to add user feedback: $error'));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProvideFeedback()));
                          }
                        },
                        fontSize: 17,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.w300,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey.shade900,
                        margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                        borderRadius: BorderRadius.circular(12.0),
                        borderSideColor: Colors.grey.shade900),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
