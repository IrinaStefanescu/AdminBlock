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

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: 2,
          backgroundColor: Color(0xF5F3A866),
          activeColor: Colors.white,
          inactiveColor: Color(0xFF7B4937),
          iconSize: 35,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner), label: 'Send docs'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: 'Pay bill'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.wash), label: 'Indexes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: 'Meeting'),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: SendDocs(),
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: PayBill(),
                );
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return Dashboard();
              });
            case 3:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Indexes(),
                );
              });
            case 4:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Meeting(),
                );
              });
            default:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Dashboard(),
                );
              });
          }
        });
  }
}
