import 'package:admin_block/pages/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final _addressFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final streetController = TextEditingController();
  final numberStreetController = TextEditingController();
  final buildingController = TextEditingController();
  final apartmentController = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final displayName = FirebaseAuth.instance.currentUser!.displayName;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    streetController.dispose();
    numberStreetController.dispose();
    buildingController.dispose();
    apartmentController.dispose();
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
                Text(
                  'Enter your name',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                Text(
                  'Enter your username',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                Text(
                  'Enter your street',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                Text(
                  'Enter your street number',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                Text(
                  'Enter your building',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                Text(
                  'Enter your apartment',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
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
                          await users_data
                              .doc(user!.uid)
                              .set({
                                'name': name,
                                'username': username,
                                'street': street,
                                'streetNumber': numberStreet,
                                'building': building,
                                'apartment': apartment
                              })
                              .then((value) => print("User's data added"))
                              .catchError((error) =>
                                  print('Failed to add user: $error'));
                          print("Name: $name");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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
