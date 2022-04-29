import 'package:admin_block/components/background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final displayName = FirebaseAuth.instance.currentUser!.displayName;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF39431),
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
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset('lib/assets/images/verify_email.png'),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_rounded,
                              color: Colors.brown,
                            ),
                            Text(
                              'Email',
                              style: GoogleFonts.inter(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        Text(
                          '$email',
                          style: GoogleFonts.inter(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.brown,
                        ),
                        Text(
                          'Creation time:',
                          style: GoogleFonts.inter(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        Text(
                          '${creationTime.toString().substring(0, 10)}',
                          style: GoogleFonts.inter(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
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

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.pin_drop,
                                              color: Colors.brown,
                                            ),
                                            Text(
                                              "Address",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50.0),
                                            child: Text(
                                              "${data['street']} street "
                                              "${data['streetNumber']}, "
                                              "building ${data['building']}, "
                                              "\napartment ${data['apartment']}",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.contacts,
                                              color: Colors.brown,
                                            ),
                                            Text(
                                              "Name:",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50.0),
                                            child: Text(
                                              "${data['name']}",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_sharp,
                                              color: Colors.brown,
                                            ),
                                            Text(
                                              "Username:",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50.0),
                                            child: Text(
                                              "${data['username']}",
                                              style: GoogleFonts.inter(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
