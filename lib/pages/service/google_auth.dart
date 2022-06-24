import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthClass(this.auth);

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      //param care indica tipul de acces cerut.Google se ocupa de autentif
      // user-ului si a contentului sau. Rezultatul e un cod de autorizatie
      // pe care aplicatia il da in schimbul unui token de acces si a unui token de refesh.
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // cream un nou credential
        final userCredential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        );

        await auth.signInWithCredential(userCredential);
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            e.toString(),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      );
    }
  }

  Future<void> signOutFromGoogle() async {
    // await googleSignIn.disconnect();
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
