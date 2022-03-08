import 'dart:io';
import 'package:admin_block/pages/download_standardized_document_five.dart';
import 'package:admin_block/pages/download_standardized_document_four.dart';
import 'package:admin_block/pages/download_standardized_document_one.dart';
import 'package:admin_block/pages/download_standardized_document_six.dart';
import 'package:admin_block/pages/download_standardized_document_three.dart';
import 'package:admin_block/pages/download_standardized_document_two.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> downloadFileExample() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/document1.jpg');

    try {
      await FirebaseStorage.instance
          .ref('documents/document1.jpg')
          .writeToFile(downloadToFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text('Dashboard', style: GoogleFonts.inter(
            color: Colors.grey[900],
            fontWeight: FontWeight.w600,
            fontSize: 20,

          ),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text('Your information', style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,

                ),),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return Center(child: CircularProgressIndicator()); // 👈 user is loading
              }

              final user = FirebaseAuth.instance.currentUser;
              final uid = user!.uid;// 👈 get the UID
              if (user != null) {
                print(user);

                CollectionReference users = FirebaseFirestore.instance.collection('users');

                return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(uid).get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 8,
                            decoration: BoxDecoration(color: Color(0x88A56333), borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Text("Hello, ${data['name']}", style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,

                                ),),
                                Row(
                                  children: [
                                    Text("Street: ${data['street']}", style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,

                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Street no.: ${data['streetNumber']}", style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,

                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Building: ${data['building']}", style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,

                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Apartment: ${data['apartment']}", style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,

                                    ),),
                                  ],
                                ),
                              ],
                            )),
                      );
                    }
                    return CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),

                    );
                  },
                );
              } else {
                return Text("user is not logged in");
              }
            },),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                onPressed: (){},
                child: Text('Calculate your maintenance',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text('Standardized applications', style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,

                ),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFEC936E), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentOne()));
                      },
                      child: Center(
                        child: Text('Remove person from house-keeping', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                    ),),
                      ),),),),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFF795C48), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentTwo()));
                      },
                      child: Center(
                        child: Text('Meter reading form', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                    ),),
                      ),),),),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFEE882F), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentThree()));
                      },
                      child: Center(
                        child: Text('Returning working capital', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                    ),),
                      ),),),),
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
                    decoration: BoxDecoration(color: Color(0xFF993737), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentFour()));
                      },
                      child: Text('Sale-purchase certificate', style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),),),),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0x88A56333), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentFive()));
                      },
                      child: Text('Owners association application', style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),),),),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFE7C878), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentSix()));
                      },
                      child: Text('Add person for house-keeping', style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),),),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(color: Color(0xFFAC4B32), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                onPressed: (){},
                child: Text('Complaints related to neighbours',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
