import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/pages/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key}) : super(key: key);

  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  var email = "";

  final _deleteDataAndAccountFormKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    CollectionReference delete_data_account =
        FirebaseFirestore.instance.collection('delete_data_and_account');
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
                'Delete Data & Account',
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
          key: _deleteDataAndAccountFormKey,
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Text(
                    'Request to have your Data and AdminBlock account removed',
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
                      EdgeInsets.only(left: 35, top: 10, bottom: 60, right: 40),
                  child: Text(
                    'AdminBlock: Please note that by asking to be forgotten by AdminBlock, all of your personal information and data will be removed from our database.',
                    style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
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
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 25, top: 10, bottom: 40, right: 40),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'I would like to request to remove my \ndata and account from AdminBlock.',
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: ButtonPrimary(
                      title: 'SUBMIT',
                      action: () async {
                        if (_deleteDataAndAccountFormKey.currentState!
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
                          await delete_data_account
                              .doc(user!.uid)
                              .set({
                                'email': _emailController.text,
                              })
                              .then((value) => print("User's data added"))
                              .catchError((error) =>
                                  print('Failed to add user: $error'));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeleteUser()));
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
