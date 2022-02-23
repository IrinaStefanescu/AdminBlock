import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_block/pages/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();

  var email = "";
  final emailController = TextEditingController();

  resetUserPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          ' Password reset email has been sent! ',
            style:  GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
        ),
      ),);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseException catch(error){
      if(error.code == 'user-not-found'){
        print('No user found for that email address.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            ' No user found for that email address! ',
            style:  GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));
                }
            ),
            Center(child: Text("RESET PASSWORD")),
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
            SizedBox(height: 30,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              child:Image.asset('lib/images/logo.png', width: 300, height: 260,),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'Reset link will be send to you email address.',
                style: GoogleFonts.inter(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            fillColor: Color(0x70E0E0E0),
                            filled: true,
                            focusColor: Colors.grey[700],
                            hoverColor: Colors.grey[700],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 15.0,
                            ),
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter email address.';
                            }
                            else if(!value.contains('@')){
                              return 'Please enter a valid email.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    email = emailController.text;
                                  });
                                  resetUserPassword();
                                }
                              },
                              child: Text(
                                ' Send email ',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[700],
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'LOGIN ',
                                style: GoogleFonts.inter(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Don\'t have an account? ',
                              style: GoogleFonts.inter(
                                color: Colors.orangeAccent,
                                fontSize: 17,
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: (){
                                  Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, a, b) => RegisterPage(),
                                  transitionDuration: Duration(seconds: 0),
                                  ), (route) => false);
                                },
                                child: Text(
                                  'REGISTER ',
                                  style: GoogleFonts.inter(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'lib/images/custom_elipses.png',
                  width: 160,
                  height: 140,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
