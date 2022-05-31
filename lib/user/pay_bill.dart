import 'dart:convert';

import 'package:admin_block/pages/blink_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PayBill extends StatefulWidget {
  const PayBill({Key? key}) : super(key: key);

  @override
  _PayBillState createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> with SingleTickerProviderStateMixin {
  final double minScale = 1;
  final double maxScale = 4;

  TransformationController controller = TransformationController();
  Animation<Matrix4>? animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Map<String, dynamic>? paymentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Text(
              'Pay house-keeping bill',
              style: GoogleFonts.inter(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 140,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: InteractiveViewer(
              transformationController: controller,
              minScale: minScale,
              maxScale: maxScale,
              clipBehavior: Clip.none,
              scaleEnabled: true,
              panEnabled: true,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: Image.asset(
                    'lib/assets/images/intretinere.png',
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 140,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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
                    height: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "The zoom feature is enabled. You \ncan zoom in and out as in the gif below.",
                          style: GoogleFonts.mukta(
                            fontSize: 18,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.asset(
                          "lib/assets/images/zoom-fingers.gif",
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 150,
                        ),
                      ],
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
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: BlinkWidget(
                  children: [
                    Icon(
                      Icons.info_outlined,
                      color: Colors.grey.shade900,
                      size: 30,
                    ),
                    Icon(
                      Icons.info_outlined,
                      color: Colors.transparent,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }
                final user = FirebaseAuth.instance.currentUser;
                final uid = user!.uid;
                if (user != null) {
                  print(user);

                  CollectionReference user_bill = FirebaseFirestore.instance
                      .collection('users_housekeeping_bills');

                  return FutureBuilder<DocumentSnapshot>(
                    future: user_bill.doc(uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text(
                          'You first need to enter Indexes and Maintenance screens and complete those steps in order to pay your bill.',
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.start,
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          'The payment amount for the current month is ${data['house_keeping_bill'].toString()} RON.'
                          '\nZoom in on the picture above to be able to check if the total payment amount is \nthe same as the one mentioned above.',
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.start,
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
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () async {
              await makeUserPayment();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 55,
              width: 200,
              child: Center(
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> makeUserPayment() async {
    final user = FirebaseAuth.instance.currentUser;
    final user_bill = await FirebaseFirestore.instance
        .collection('users_housekeeping_bills')
        .doc(user?.uid)
        .get();
    try {
      paymentData =
          await createUserPayment(user_bill['house_keeping_bill'], 'RON');
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            primaryButtonColor: Colors.deepOrange,
            paymentIntentClientSecret: paymentData?['client_secret'],
            applePay: true,
            googlePay: true,
            testEnv: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'RON ',
            merchantDisplayName:
                FirebaseAuth.instance.currentUser?.displayName.toString(),
          ))
          .then((value) {});

      displayUserPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayUserPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('Payment intent id...' + paymentData!['id'].toString());
        print('Payment intent client_secret...' +
            paymentData!['client_secret'].toString());
        print('Payment intent amount...' + paymentData!['amount'].toString());
        print('Payment intent data...' + paymentData.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Successfully payed your bill!")));

        //paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createUserPayment(String userBill, String userCurrency) async {
    final user = FirebaseAuth.instance.currentUser;
    final user_bill = await FirebaseFirestore.instance
        .collection('users_housekeeping_bills')
        .doc(user?.uid)
        .get();
    try {
      Map<String, dynamic> body = {
        'amount': calculateUserAmount(
          user_bill['house_keeping_bill'],
        ),
        'currency': userCurrency,
        'payment_method_types[]': 'card'
      };
      var stripeApiResponse = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L4gMzA5V4GUDZql4LMqPGqHoqehyyGlok1tu3B5FXjuD7ph4mf0sPTOQtByV2kLTONf0VB5BPqARhM1HIqYYOkh00L4NC0EZ9',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${stripeApiResponse.body.toString()}');
      return jsonDecode(stripeApiResponse.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateUserAmount(String userBill) {
    return (int.parse(userBill) * 100).toString();
  }
}
