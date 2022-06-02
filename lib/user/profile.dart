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
  var username = "";
  final usernameController = TextEditingController();
  final _profileFormKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Form(
        key: _profileFormKey,
        child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    'Private Information',
                    style: GoogleFonts.inter(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset('lib/assets/images/verify_email.png'),
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
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
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
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
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
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
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
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 35,
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            fillColor: Color(0x70E0E0E0),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                            focusColor: Colors.grey[700],
                            hoverColor: Colors.grey[700],
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 15.0,
                            ),
                          ),
                          controller: usernameController,
                          onChanged: (value) {
                            username = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AlertDialog(
                                    title: Text(
                                      'Edit username',
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    content: Text(
                                      'Close and re-open this screen to see the update.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close')),
                                    ],
                                  ),
                                );
                              },
                            );
                            await FirebaseFirestore.instance
                                .collection('users_data')
                                .doc(uid)
                                .update({
                              'username': usernameController.text,
                            });
                          },
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
    );
  }
}
