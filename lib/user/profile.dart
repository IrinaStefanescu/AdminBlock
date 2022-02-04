import 'package:admin_block/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async{
    if(user!= null && user!.emailVerified){
      await user!.sendEmailVerification();
      print(' Verification Email has been sent ');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text(''),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Profile",
              style: GoogleFonts.mukta(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xD3F5B75B),
        shadowColor: Color(0xD3F5B75B),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Image.asset('lib/images/verify_email.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You are one step away from \naccessing our features!',
                  style: GoogleFonts.mukta(
                    fontSize: 25,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
            Text(
              'Email: $email',
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                  'Logout'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Verify your email'),
                  onPressed: (){
                    verifyEmail();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
