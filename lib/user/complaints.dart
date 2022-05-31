import 'package:admin_block/user/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../pages/service/notifications_api.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  var name = "";
  var issue = "";
  String _selectedDate = 'Tap to select date';

  final _compliantsFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final issueController = TextEditingController();

  final email = FirebaseAuth.instance.currentUser!.email;

  void listenNotifications() => NotificationApi.onNotificationsCallback.stream
      .listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Dashboard()));

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  @override
  void dispose() {
    nameController.dispose();
    issueController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2023),
      builder: (context, child) => Theme(
        child: child!,
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.deepOrange,
            onPrimary: Colors.white,
            surface: Colors.deepOrange,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
      ),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users_compliants =
        FirebaseFirestore.instance.collection('users_compliants');
    final user = FirebaseAuth.instance.currentUser;

    return Material(
      child: Form(
        key: _compliantsFormKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
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
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    'Complete complaint',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Row(
                    children: [
                      Text(
                        'Enter your name',
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Color(0x70E0E0E0),
                      filled: true,
                      focusColor: Colors.orange,
                      hoverColor: Colors.orange,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 15.0,
                      ),
                    ),
                    controller: nameController,
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Row(
                    children: [
                      Text(
                        'Enter your issue',
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    maxLines: 8,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Color(0x70E0E0E0),
                      filled: true,
                      focusColor: Colors.orange,
                      hoverColor: Colors.orange,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 15.0,
                      ),
                    ),
                    controller: issueController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Open the calendar and choose the date \nthe incident happened',
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 60,
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 2.0, color: Colors.orange),
                        left: BorderSide(width: 2.0, color: Colors.orange),
                        right: BorderSide(width: 2.0, color: Colors.orange),
                        bottom: BorderSide(width: 2.0, color: Colors.orange),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          _selectedDate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        tooltip: 'Tap to open calendar',
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[700],
                    ),
                    child: TextButton(
                      child: Text(
                        'Submit',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
                      ),
                      onPressed: () async {
                        if (_compliantsFormKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Sending data...',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                          await users_compliants
                              .doc(user!.uid)
                              .set({
                                'name': name,
                                'email': email,
                                'issue': issue,
                                'compliant_date': _selectedDate,
                              })
                              .then((value) => print("User's data added"))
                              .catchError((error) =>
                                  print('Failed to add user: $error'));
                          print("Name: $name");
                          NotificationApi.showNotification(
                            title: "AdminBlock Notification",
                            body: "Compliant successfully sent!",
                            payload: "compliant_sent",
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        }
                      },
                    ),
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
