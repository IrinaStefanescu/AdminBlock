import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/user/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculateMaintenance extends StatefulWidget {
  @override
  _CalculateMaintenanceState createState() => _CalculateMaintenanceState();
}

class _CalculateMaintenanceState extends State<CalculateMaintenance> {
  final _calculateMaintenanceFormKey = GlobalKey<FormState>();

  final userGeneralCosts = 48.52;
  late double userGeneralWaterCosts;
  late double userGeneralHeatCosts;
  late double userGeneralGasesCosts;
  late double userMaintenanceBill;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _calculateMaintenanceFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
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
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
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

                    CollectionReference costsPerApartment = FirebaseFirestore
                        .instance
                        .collection('users_general_costs');

                    return FutureBuilder<DocumentSnapshot>(
                      future:
                          costsPerApartment.doc('costs_per_apartment').get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: ExpansionTile(
                                    iconColor: Colors.white,
                                    collapsedIconColor: Colors.white,
                                    backgroundColor: Color(0xFFFCC075),
                                    collapsedBackgroundColor:
                                        Colors.orangeAccent,
                                    collapsedTextColor: Colors.white,
                                    textColor: Colors.white,
                                    title: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Text(
                                        'Users costs per apartment',
                                        style: GoogleFonts.inter(
                                          //color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Table(
                                          columnWidths: {
                                            0: FractionColumnWidth(0.1),
                                            1: FractionColumnWidth(0.6),
                                            2: FractionColumnWidth(0.3),
                                          },
                                          border: TableBorder.all(
                                              color: Colors.grey,
                                              style: BorderStyle.solid,
                                              width: 2),
                                          children: [
                                            TableRow(children: [
                                              Column(children: [
                                                Text(
                                                  'No',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.grey.shade800,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ]),
                                              Column(children: [
                                                Text(
                                                  'Type',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.grey.shade800,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ]),
                                              Column(children: [
                                                Text(
                                                  'Value',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.grey.shade800,
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
                                  ),
                                ),
                              ],
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
                height: 3,
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

                    CollectionReference costsPerPerson = FirebaseFirestore
                        .instance
                        .collection('users_general_costs');

                    return FutureBuilder<DocumentSnapshot>(
                      future: costsPerPerson.doc('costs_per_person').get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Center(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      backgroundColor: Color(0xFFFCC075),
                                      collapsedBackgroundColor:
                                          Colors.orangeAccent,
                                      collapsedTextColor: Colors.white,
                                      textColor: Colors.white,
                                      title: Text(
                                        'User\'s costs per person',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      children: [
                                        Text(
                                          "Light: ${data['light']} RON",
                                          style: GoogleFonts.inter(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                      ],
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
                height: 3,
              ),
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final user = FirebaseAuth.instance.currentUser;
                  final uid = user?.uid;
                  if (user != null) {
                    print(user);

                    CollectionReference indexesValues =
                        FirebaseFirestore.instance.collection('indexes');

                    return FutureBuilder<DocumentSnapshot>(
                      future: indexesValues.doc(uid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 0.5,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(
                                'Attention!',
                                style: GoogleFonts.inter(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                children: [
                                  Text(
                                    'In order to have access to all of your maintenance costs you should first enter your'
                                    ' water indexes.',
                                    style: GoogleFonts.inter(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 0),
                                    child: Text(
                                      'Please complete Indexes Page first.',
                                      style: GoogleFonts.inter(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.inter(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
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

                          userGeneralWaterCosts = totalWaterCosts;

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Center(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      backgroundColor: Color(0xFFFCC075),
                                      collapsedBackgroundColor:
                                          Colors.orangeAccent,
                                      collapsedTextColor: Colors.white,
                                      textColor: Colors.white,
                                      title: Text(
                                        'User\'s individual water coasts',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      children: [
                                        Text(
                                          '(based on indexes introduced by you)',
                                          style: GoogleFonts.inter(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
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
                                      ],
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
                height: 3,
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

                    final uid = user.uid;
                    CollectionReference costsPerPerson =
                        FirebaseFirestore.instance.collection('users_data');

                    return FutureBuilder<DocumentSnapshot>(
                      future: costsPerPerson.doc(uid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          var numberOfPersonsInApartment =
                              double.parse(data['number_of_persons']);
                          var totalNumberOfPersons = 45;
                          var totalGasesBill = 310;
                          var totalHeatBill = 1440;

                          var individualHeatCost =
                              (totalHeatBill / totalNumberOfPersons) *
                                  numberOfPersonsInApartment;
                          var individualGasesCost =
                              (totalGasesBill / totalNumberOfPersons) *
                                  numberOfPersonsInApartment;

                          userGeneralHeatCosts = individualHeatCost;
                          userGeneralGasesCosts = individualGasesCost;

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Center(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      backgroundColor: Color(0xFFFCC075),
                                      collapsedBackgroundColor:
                                          Colors.orangeAccent,
                                      collapsedTextColor: Colors.white,
                                      textColor: Colors.white,
                                      title: Text(
                                        'Number of persons declared',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      children: [
                                        Text(
                                          "${numberOfPersonsInApartment.toStringAsFixed(0)}",
                                          style: GoogleFonts.inter(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      backgroundColor: Color(0xFFFCC075),
                                      collapsedBackgroundColor:
                                          Colors.orangeAccent,
                                      collapsedTextColor: Colors.white,
                                      textColor: Colors.white,
                                      title: Text(
                                        'Individual heat cost',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      children: [
                                        Text(
                                          "$individualHeatCost RON",
                                          style: GoogleFonts.inter(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      backgroundColor: Color(0xFFFCC075),
                                      collapsedBackgroundColor:
                                          Colors.orangeAccent,
                                      collapsedTextColor: Colors.white,
                                      textColor: Colors.white,
                                      title: Text(
                                        'Individual gases cost',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      children: [
                                        Text(
                                          "${individualGasesCost.toStringAsFixed(2)} RON",
                                          style: GoogleFonts.inter(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
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
              ButtonPrimary(
                  title: 'CALCULATE',
                  action: () async {
                    userMaintenanceBill = userGeneralCosts +
                        userGeneralGasesCosts +
                        userGeneralHeatCosts +
                        userGeneralWaterCosts;
                    print(
                        "User bill: " + userMaintenanceBill.toStringAsFixed(2));

                    CollectionReference usersHousekeepingBills =
                        FirebaseFirestore.instance
                            .collection('users_housekeeping_bills');

                    final user = FirebaseAuth.instance.currentUser;

                    await usersHousekeepingBills
                        .doc(user!.uid)
                        .set({
                          'email': user.email,
                          'house_keeping_bill':
                              userMaintenanceBill.toStringAsFixed(0),
                        })
                        .then((value) => print(
                            "User housekeeping bill saved in Cloud Firestore."))
                        .catchError((error) => print(
                            'Failed to add user housekeeping bill: $error'));

                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AlertDialog(
                          title: Text(
                            'House-keeping Bill.',
                            style: GoogleFonts.inter(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          content: Text(
                            'You should pay ${userMaintenanceBill.toStringAsFixed(0)} RON.',
                            style: GoogleFonts.inter(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              child: Text('OK',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  )),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  fontSize: 20,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrangeAccent,
                  margin: EdgeInsets.fromLTRB(32, 0, 32, 20),
                  borderRadius: BorderRadius.circular(12.0),
                  borderSideColor: Colors.deepOrange),
            ],
          ),
        ),
      ),
    );
  }
}
