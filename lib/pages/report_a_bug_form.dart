import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/pages/service/validators.dart';
import 'package:admin_block/pages/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({Key? key}) : super(key: key);

  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  var email = "";
  var bug = "";

  final _bugsFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

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

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey[900];
    }
    return Colors.grey[900];
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference reported_bugs =
        FirebaseFirestore.instance.collection('reported_bugs_form');
    final user = FirebaseAuth.instance.currentUser;

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
                'Report a Bug',
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
      body: SingleChildScrollView(
        child: Form(
          key: _bugsFormKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Text(
                    'Report a bug or issue in the mobile app',
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
                    'Use this form to report any bugs you encounter with the Admin Block Android mobile app.',
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
                            fontWeight: FontWeight.w400,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 30, 10, 0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                              'My issue is: Please share details like phone,\nOS version, device screen size etc ',
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    controller: _bodyController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      fillColor: Color(0x70E0E0E0),
                      filled: true,
                      labelText: 'Body...',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
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
                      bug = value;
                    },
                    validator: UserInputValidator.validateUserAddressFields,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: ButtonPrimary(
                      title: 'SUBMIT',
                      action: () async {
                        if (_bugsFormKey.currentState!.validate()) {
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
                          await reported_bugs
                              .doc(user!.uid)
                              .set({
                                'email': _emailController.text,
                                'bug': _bodyController.text,
                              })
                              .then((value) => print("User's data added"))
                              .catchError((error) =>
                                  print('Failed to add user: $error'));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportBug()));
                        }
                      },
                      fontSize: 17,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.w300,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey.shade900,
                      margin: EdgeInsets.fromLTRB(32, 0, 32, 20),
                      borderRadius: BorderRadius.circular(12.0),
                      borderSideColor: Colors.grey.shade900),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
