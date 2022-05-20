import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/pages/blink_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Indexes extends StatefulWidget {
  @override
  State<Indexes> createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> with SingleTickerProviderStateMixin {
  var coldWaterBathroom = "";
  var warmWaterBathroom = "";
  var coldWaterKitchen = "";
  var warmWaterKitchen = "";

  final _indexesFormKey = GlobalKey<FormState>();
  final TextEditingController _coldWaterBathroomController =
      TextEditingController();
  final TextEditingController _warmWaterBathroomController =
      TextEditingController();
  final TextEditingController _coldWaterKitchenController =
      TextEditingController();
  final TextEditingController _warmWaterKitchenController =
      TextEditingController();

  CollectionReference indexes =
      FirebaseFirestore.instance.collection('indexes');
  final user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _warmWaterBathroomController.dispose();
    _warmWaterKitchenController.dispose();
    _coldWaterBathroomController.dispose();
    _coldWaterKitchenController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _indexesFormKey,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          'Send your water indexes',
                          style: GoogleFonts.inter(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text(
                          'Please enter the values of the hot and cold water reading indexes in the fields below (number of cubic meters):',
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          child: Text(
                            'Cold water',
                            style: GoogleFonts.inter(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            child: Text(
                              'Bathroom:',
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              'Kitchen:',
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: _coldWaterBathroomController,
                              decoration: const InputDecoration(
                                fillColor: Color(0x70E0E0E0),
                                filled: true,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                labelText: '     3',
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onChanged: (value) {
                                coldWaterBathroom = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: _coldWaterKitchenController,
                              decoration: const InputDecoration(
                                fillColor: Color(0x70E0E0E0),
                                filled: true,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                labelText: '     3',
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onChanged: (value) {
                                coldWaterKitchen = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          child: Text(
                            'Warm water',
                            style: GoogleFonts.inter(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            child: Text(
                              'Bathroom:',
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              'Kitchen:',
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: _warmWaterBathroomController,
                              decoration: const InputDecoration(
                                fillColor: Color(0x70E0E0E0),
                                filled: true,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                labelText: '     3',
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onChanged: (value) {
                                warmWaterBathroom = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: _warmWaterKitchenController,
                              decoration: const InputDecoration(
                                fillColor: Color(0x70E0E0E0),
                                filled: true,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2)),
                                labelText: '     3',
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onChanged: (value) {
                                warmWaterKitchen = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(
                                child: Text(
                                  "Information",
                                  style: GoogleFonts.mukta(
                                    fontSize: 26,
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              content: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 110,
                                child: Text(
                                  "Price / cubic meter of cold water - 7,046 RON \nPrice / cubic meter of hot water - 11,038 RON",
                                  style: GoogleFonts.mukta(
                                    fontSize: 18,
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.mukta(
                                      fontSize: 22,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: BlinkWidget(
                          children: [
                            Image.asset(
                              'lib/assets/images/info-indexes.png',
                              width: 60,
                              height: 60,
                            ),
                            Image.asset(
                              'lib/assets/images/info-indexes.png',
                              width: 60,
                              height: 60,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: ButtonPrimary(
                            title: 'SUBMIT',
                            action: () async {
                              if (_indexesFormKey.currentState!.validate()) {
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
                                await indexes
                                    .doc(user!.uid)
                                    .set({
                                      'email': email.toString(),
                                      'cold_water_kitchen':
                                          _coldWaterKitchenController.text,
                                      'warm_water_kitchen':
                                          _warmWaterKitchenController.text,
                                      'cold_water_bathroom':
                                          _coldWaterBathroomController.text,
                                      'warm_water_bathroom':
                                          _warmWaterBathroomController.text,
                                    })
                                    .then((value) => print("User's data added"))
                                    .catchError((error) =>
                                        print('Failed to add user: $error'));

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Indexes()));
                              }
                            },
                            fontSize: 17,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w300,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey.shade900,
                            margin: EdgeInsets.fromLTRB(32, 0, 32, 20),
                            borderRadius: BorderRadius.circular(12.0),
                            borderSideColor: Colors.grey.shade900),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
