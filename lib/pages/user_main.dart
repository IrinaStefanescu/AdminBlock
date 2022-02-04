import 'package:crypto_wallet_licenta/user/dashboard.dart';
import 'package:crypto_wallet_licenta/user/indexes.dart';
import 'package:crypto_wallet_licenta/user/meeting.dart';
import 'package:crypto_wallet_licenta/user/pay_bill.dart';
import 'package:crypto_wallet_licenta/user/profile.dart';
import 'package:crypto_wallet_licenta/user/send_docs.dart';
import 'package:crypto_wallet_licenta/pages/settings.dart';
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
      body: _widgetOptions.elementAt(_selectedIndex),
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
