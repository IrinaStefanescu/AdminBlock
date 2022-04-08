import 'dart:io';

import 'package:admin_block/pages/download_standardized_document_five.dart';
import 'package:admin_block/pages/download_standardized_document_four.dart';
import 'package:admin_block/pages/download_standardized_document_one.dart';
import 'package:admin_block/pages/download_standardized_document_six.dart';
import 'package:admin_block/pages/download_standardized_document_three.dart';
import 'package:admin_block/pages/download_standardized_document_two.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ImagePicker image = ImagePicker();
  String url = "";
  File? file;

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  uploadFile() async {
    var imageFile =
        FirebaseStorage.instance.ref().child("profile-images").child("/.jpg");
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;

    url = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("images").doc().set({
      "imageUrl": url,
    });
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Material(
            elevation: 10,
            shadowColor: Colors.grey,
            child: Container(
              color: Color(0x88A56333),
              height: 150,
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // 👈 user is loading
                  }
                  final user = FirebaseAuth.instance.currentUser;
                  final uid = user!.uid; // 👈 get the UID
                  if (user != null) {
                    print(user);

                    CollectionReference users =
                        FirebaseFirestore.instance.collection('users');
                    CollectionReference images =
                        FirebaseFirestore.instance.collection('images');

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
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${data['name']}",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "${data['street']} street, no ${data['streetNumber']}",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "Building ${data['building']}",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "Apartment ${data['apartment']}",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            getImage();
                                            uploadFile();
                                          },
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage: file == null
                                                ? AssetImage(
                                                    'lib/images/placeholder.png')
                                                : FileImage(File(file!.path))
                                                    as ImageProvider,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent),
                        );
                      },
                    );
                  } else {
                    return Text("user is not logged in");
                  }
                },
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return Center(
                      child: CircularProgressIndicator()); // 👈 user is loading
                }

                final user = FirebaseAuth.instance.currentUser;
                final uid = user!.uid; // 👈 get the UID
                if (user != null) {
                  print(user);

                  CollectionReference images =
                      FirebaseFirestore.instance.collection('images');

                  FutureBuilder(
                      future: images.doc(uid).get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: 200,
                            height: 100,
                            child:
                                Image.network(snapshot.data!.docs['imageUrl']),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                } else {
                  return Text("user is not logged in");
                }
                return Center(
                  child: Container(),
                );
              }),
          SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.height / 14,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Calculate your maintenance',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Standardized applications',
              style: GoogleFonts.inter(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEC936E),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentOne()));
                      },
                      child: Center(
                        child: Text(
                          'Remove person from house-keeping',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF795C48),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentTwo()));
                      },
                      child: Center(
                        child: Text(
                          'Meter reading form',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEE882F),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentThree()));
                      },
                      child: Center(
                        child: Text(
                          'Returning working capital',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF993737),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentFour()));
                      },
                      child: Text(
                        'Sale-purchase certificate',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0x88A56333),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentFive()));
                      },
                      child: Text(
                        'Owners association application',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFE7C878),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentSix()));
                      },
                      child: Text(
                        'Add person for house-keeping',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Complaints',
              style: GoogleFonts.inter(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(
                color: Color(0xFFAC4B32),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Complaints related to neighbours',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
