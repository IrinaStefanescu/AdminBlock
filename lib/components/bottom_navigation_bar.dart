import 'package:admin_block/user/dashboard.dart';
import 'package:admin_block/user/indexes.dart';
import 'package:admin_block/user/meeting.dart';
import 'package:admin_block/user/pay_bill.dart';
import 'package:admin_block/user/send_docs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationNavBar extends StatefulWidget {
  const BottomNavigationNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavigationNavBarState createState() => _BottomNavigationNavBarState();
}

class _BottomNavigationNavBarState extends State<BottomNavigationNavBar> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    SendDocs(),
    HomePage(),
    Dashboard(),
    Indexes(),
    Meeting(),
  ];

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        color: Color(0xF5F3A866),
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Color(0xF5F3A866)),
            child: BottomNavigationBar(
              onTap: changeIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.document_scanner,
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
                    icon: Icon(Icons.camera_alt_sharp), label: "Indexes"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_call), label: "Meeting"),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Color(0xFF7B4937),
              backgroundColor: Color(0xF5F3A866),
            ),
          ),
        ),
      ),
    );
  }
}
