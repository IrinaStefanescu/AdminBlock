import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';

class CalculateMaintenance extends StatefulWidget {
  @override
  _CalculateMaintenanceState createState() => _CalculateMaintenanceState();
}

class _CalculateMaintenanceState extends State<CalculateMaintenance> {
  final _calculateMaintenanceFormKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _calculateMaintenanceFormKey,
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
                    'Calculate maintenance',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    'Users costs per apartment',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      print(user);

                      CollectionReference costs_per_apartment =
                          FirebaseFirestore.instance
                              .collection('users_general_costs');

                      return FutureBuilder<DocumentSnapshot>(
                        future: costs_per_apartment
                            .doc('costs_per_apartment')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.1),
                                      1: FractionColumnWidth(0.6),
                                      2: FractionColumnWidth(0.3),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.deepOrange,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: [
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            'No',
                                            style: GoogleFonts.inter(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Type',
                                            style: GoogleFonts.inter(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Value',
                                            style: GoogleFonts.inter(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            '1',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Intercom services',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            "${data['intercom_services']} RON",
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            '2',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Repair fund',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            "${data['repair_fund']} RON",
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            '3',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Salaries',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            "${data['salaries']} RON",
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            '4',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Stair cleaning',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            "${data['stair_cleaning']} RON",
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Text(
                                            '5',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            'Tax',
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                        Column(children: [
                                          Text(
                                            "${data['tax']} RON",
                                            style: GoogleFonts.inter(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          )
                                        ]),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Text("user is not logged in");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      print(user);

                      CollectionReference costs_per_person = FirebaseFirestore
                          .instance
                          .collection('users_general_costs');

                      return FutureBuilder<DocumentSnapshot>(
                        future: costs_per_person.doc('costs_per_person').get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Users costs per person',
                                      style: GoogleFonts.inter(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Light: ${data['light']} RON",
                                      style: GoogleFonts.inter(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Text("user is not logged in");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final user = FirebaseAuth.instance.currentUser;
                    final uid = user!.uid;
                    if (user != null) {
                      print(user);

                      CollectionReference indexes_values =
                          FirebaseFirestore.instance.collection('indexes');

                      return FutureBuilder<DocumentSnapshot>(
                        future: indexes_values.doc(uid).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            var doubleColdBathroomWaterIndex =
                                double.parse(data['cold_water_bathroom']);
                            var coldWaterBathroomCosts =
                                7.046 * doubleColdBathroomWaterIndex;
                            var doubleColdKitchenWaterIndex =
                                double.parse(data['cold_water_kitchen']);
                            var coldWaterKitchenCosts =
                                7.046 * doubleColdKitchenWaterIndex;

                            var doubleWarmBathroomWaterIndex =
                                double.parse(data['warm_water_bathroom']);
                            var warmWaterBathroomCosts =
                                11.038 * doubleWarmBathroomWaterIndex;
                            var doubleWarmKitchenWaterIndex =
                                double.parse(data['warm_water_kitchen']);
                            var warmWaterKitchenCosts =
                                11.038 * doubleWarmKitchenWaterIndex;

                            var totalWaterCosts = coldWaterBathroomCosts +
                                coldWaterKitchenCosts +
                                warmWaterBathroomCosts +
                                warmWaterKitchenCosts;

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 10, 5),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Kitchen and bathroom water costs based on indexes introduced by you.',
                                      style: GoogleFonts.inter(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${totalWaterCosts.toStringAsFixed(2)} RON",
                                      style: GoogleFonts.inter(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'In order to see your costs for gas and heat you need to enter the number of persons in your apartment.',
                                      style: GoogleFonts.inter(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Text("user is not logged in");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
