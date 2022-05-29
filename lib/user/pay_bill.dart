import 'dart:convert';

import 'package:admin_block/pages/blink_element.dart';
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

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
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
          InkWell(
            onTap: () async {
              await makePayment();
            },
            child: Container(
              height: 50,
              width: 200,
              color: Colors.green,
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

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
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

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L4gMzA5V4GUDZql4LMqPGqHoqehyyGlok1tu3B5FXjuD7ph4mf0sPTOQtByV2kLTONf0VB5BPqARhM1HIqYYOkh00L4NC0EZ9',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
