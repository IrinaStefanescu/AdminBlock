import 'package:admin_block/user/dashboard.dart';
import 'package:admin_block/user/indexes.dart';
import 'package:admin_block/user/meeting.dart';
import 'package:admin_block/user/pay_bill.dart';
import 'package:admin_block/user/profile.dart';
import 'package:admin_block/user/send_docs.dart';
import 'package:admin_block/pages/settings.dart';
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

  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    SendDocs(),
    PayBill(),
    Dashboard(),
    Indexes(),
    Meeting(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "WELCOME",
              style: GoogleFonts.mukta(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(child: Container(),),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.person, color: Colors.brown,),
              onPressed: (){
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Profile();
                  },
                );
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              }),
            IconButton(
              constraints: BoxConstraints(),
              icon: Icon(Icons.settings, color: Colors.brown,),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
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
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 6,
                          color: Color(0x56018477),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Hello, ${data['name']}"),
                              Text("${data['street']}"),
                              Text("${data['streetNumber']}"),
                              Text("${data['building']}"),
                              Text("${data['apartment']}"),
                            ],
                          )),
                    );
                  }
                  return Text("loading");
                },
              );
            } else {
              return Text("user is not logged in");
            }
          },),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xF5F3A866)),
        child: BottomNavigationBar(
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner,
              ),
              label: "Send Docs",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: "Pay bill",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_sharp),
              label: "Indexes"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call),
                label: "Meeting"
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF7B4937),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
