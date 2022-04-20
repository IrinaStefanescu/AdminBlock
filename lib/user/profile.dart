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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset('lib/assets/images/verify_email.png'),
          Text(
            'Email: $email',
            style: GoogleFonts.inter(
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          Text(
            'Creation time: ${creationTime.toString().substring(0, 10)}',
            style: GoogleFonts.inter(
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          Text(
            'Last seen: ${DateTime.now().toString().substring(0, 10)}',
            style: GoogleFonts.inter(
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontSize: 17,
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
                    FirebaseFirestore.instance.collection('users');

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
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          children: [
                            Text(
                              "${data['name']}",
                              style: GoogleFonts.inter(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "${data['street']} street, no ${data['streetNumber']}",
                              style: GoogleFonts.inter(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Building ${data['building']}",
                              style: GoogleFonts.inter(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Apartment ${data['apartment']}",
                              style: GoogleFonts.inter(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Username: ${data['username']}",
                              style: GoogleFonts.inter(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ],
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
          Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage(
                    'lib/assets/images/placeholder.png',
                  ),
                  backgroundColor: Colors.grey[700],
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: InkWell(
                    onTap: () {
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Choose profile photo',
            style: GoogleFonts.mukta(
              fontSize: 20,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {},
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
