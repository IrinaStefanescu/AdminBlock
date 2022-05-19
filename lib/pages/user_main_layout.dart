import 'package:admin_block/components/bottom_navigation_bar.dart';
import 'package:admin_block/pages/settings.dart';
import 'package:admin_block/user/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "WELCOME, ",
              style: GoogleFonts.mukta(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }
                final user = FirebaseAuth.instance.currentUser;
                final uid = user!.uid;
                if (user != null) {
                  print(user);

                  CollectionReference users =
                      FirebaseFirestore.instance.collection('users_data');

                  return FutureBuilder<DocumentSnapshot>(
                    future: users.doc(uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          " ${data['username']}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                } else {
                  return Text("user is not logged in");
                }
              },
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.person,
                  color: Colors.brown,
                ),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Profile();
                    },
                  );
                }),
            IconButton(
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.settings,
                color: Colors.brown,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: BottomNavigationNavBar(),
    );
  }
}
