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
      body: Column(
        children: [
          SizedBox(height: 20,),
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
                      return Text("loading");
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
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Remove person from housekeeping', style: GoogleFonts.inter(
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
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text('Return working capital', style: GoogleFonts.inter(
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
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text('Sale-purchase certificate', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,

                      ),),
                    ),),),),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0x88A56333), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Owners association application', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,

                      ),),
                    ),),),),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFE7C878), borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Add person for housekeeping', style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),),
                    ),),),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(color: Color(0xFFAC4B32), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text('Complaints related to neighbours',
                  style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  ),
              ),
            ),
          ),
        ],
      ),
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
