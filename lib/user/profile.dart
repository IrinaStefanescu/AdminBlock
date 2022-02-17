import 'package:admin_block/pages/auth/login.dart';
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
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('lib/images/placeholder.png',),
                  backgroundColor: Colors.grey[700],
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                  ),),
              ],
            ),
            Text(
              'Email: $email',
            ),
            Image.asset('lib/images/verify_email.png'),
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

  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text('Choose profile photo',
            style: GoogleFonts.mukta(
              fontSize: 20,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              FlatButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: (){},
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
