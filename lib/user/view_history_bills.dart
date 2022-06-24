import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'dashboard.dart';

class ViewHistoryBills extends StatefulWidget {
  const ViewHistoryBills({Key? key}) : super(key: key);

  @override
  _ViewHistoryBillsState createState() => _ViewHistoryBillsState();
}

class _ViewHistoryBillsState extends State<ViewHistoryBills> {
  getUserBooks() async {}

  @override
  Widget build(BuildContext context) {
    var _filteredBills = <String>[];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                        ),
                        Text(
                          'Dashboard',
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 75,
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: buildFloatingSearchBar(),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Your history bills',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 0.9,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users_history_bills')
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .collection('information')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var doc = snapshot.data!.docs;
                        print("Doc Length:" + doc.length.toString());
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          color: Colors.white,
                          child: doc.length != 0
                              ? new ListView.builder(
                                  itemCount: doc.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        height: 70,
                                        child: Card(
                                          color: Colors.amber[100],
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Icon(
                                                  Icons.payment_outlined,
                                                  size: 30,
                                                  color: Colors.deepOrange,
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    child: Text(
                                                      'Transaction ${snapshot.data!.docs[index].id}',
                                                      style: GoogleFonts.inter(
                                                        color: Colors.black45,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Date: ${snapshot.data!.docs[index]['date'].toString().substring(0, 10)}',
                                                    style: GoogleFonts.inter(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Payed: ${snapshot.data!.docs[index]['bill'].toString()} RON',
                                                    style: GoogleFonts.inter(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Text(
                                  'No history bills.',
                                  style: GoogleFonts.inter(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      borderRadius: BorderRadius.circular(25),
      hint: 'Filter',
      scrollPadding: const EdgeInsets.only(bottom: 10),
      transitionDuration: const Duration(milliseconds: 200),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      hintStyle: TextStyle(
        fontSize: 17,
        color: Colors.grey[600],
        fontWeight: FontWeight.w400,
      ),
      debounceDelay: const Duration(milliseconds: 100),
      automaticallyImplyBackButton: false,
      backdropColor: Colors.grey[200],
      backgroundColor: Colors.white,
      onQueryChanged: (query) {
        // _filteredBills.clear();
        // List<String> filteredBills = _userBills
        //     .where((option) => option.title.toLowerCase().contains(query))
        //     .toList();
        //
        // setState(() {
        //   _filteredBills = List<String>.from(filteredBills);
        // });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(),
        );
      },
    );
  }
}
