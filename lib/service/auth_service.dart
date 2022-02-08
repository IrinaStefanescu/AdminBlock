import 'package:admin_block/pages/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass{
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn(BuildContext context) async {
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      // ignore: unnecessary_null_comparison
      if (_googleSignIn != null)
        {
          GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
          AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );

          try{
            UserCredential userCredential = await auth.signInWithCredential(credential);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain()));
          }
          catch(e){
            print(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(e.toString(),
                style:  GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),),
            ),);
          }
        }
      else {
        print('Not able to sign in.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text('Not able to sign in.',
            style:  GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),),
        ),);
      }
    }
    catch(e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(e.toString(),
          style:  GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),),
      ),);
    }
  }
}