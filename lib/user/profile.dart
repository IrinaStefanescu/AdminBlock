import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}
