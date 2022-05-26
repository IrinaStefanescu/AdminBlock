import 'package:admin_block/pages/service/login.dart';
import 'package:admin_block/pages/user_main_layout.dart';
import 'package:admin_block/user/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/service/notifications_api.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  _UserAddressState createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  var name = "";
  var username = "";
  var street = "";
  var numberStreet = "";
  var building = "";
  var apartment = "";
  var numberOfPersons = "";

  final _addressFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final streetController = TextEditingController();
  final numberStreetController = TextEditingController();
  final buildingController = TextEditingController();
  final apartmentController = TextEditingController();
  final numberOfPersonsController = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final displayName = FirebaseAuth.instance.currentUser!.displayName;

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

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
    usernameController.dispose();
    streetController.dispose();
    numberStreetController.dispose();
    buildingController.dispose();
    apartmentController.dispose();
    numberOfPersonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users_data =
        FirebaseFirestore.instance.collection('users_data');
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add address",
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
      body: Center(
        child: Form(
          key: _addressFormKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'In order to have access to your \ndashboard please complete this form.',
                  style: GoogleFonts.inter(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_sharp,
                      color: Colors.deepOrange,
                    ),
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
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.drive_file_rename_outline,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter your username',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.streetview,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter your street',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: streetController,
                  onChanged: (value) {
                    street = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your street';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.format_list_numbered,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter your street number',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: numberStreetController,
                  onChanged: (value) {
                    numberStreet = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your street number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.apartment,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter your building',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: buildingController,
                  onChanged: (value) {
                    building = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your building';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.format_list_numbered,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter your apartment',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: apartmentController,
                  onChanged: (value) {
                    apartment = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your apartment';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.wc_sharp,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      'Enter no. of persons in apartment',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0x70E0E0E0),
                    filled: true,
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: numberOfPersonsController,
                  onChanged: (value) {
                    numberOfPersons = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide number of persons';
                    }
                    return null;
                  },
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
                        if (_addressFormKey.currentState!.validate()) {
                          await users_data
                              .doc(user!.uid)
                              .set({
                                'name': name,
                                'username': username,
                                'street': street,
                                'streetNumber': numberStreet,
                                'building': building,
                                'apartment': apartment,
                                'number_of_persons': numberOfPersons,
                              })
                              .then((value) => print("User's data added"))
                              .catchError((error) =>
                                  print('Failed to add user: $error'));
                          print("Name: $name");

                          try {
                            await FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  'Email verification sent!',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            print('Error: ' + e.toString());
                          }
                          if (FirebaseAuth.instance.currentUser!.providerData[0]
                                  .providerId ==
                              'google.com') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMain()));
                            NotificationApi.showNotification(
                              title: "AdminBlock Notification",
                              body: "Welcome to your Dashboard!",
                              payload: "user_login",
                            );
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
