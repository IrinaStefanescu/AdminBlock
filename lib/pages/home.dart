// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crypto_wallet_licenta/components/modal_bottom_sheet.dart';
// import 'package:crypto_wallet_licenta/pages/settings.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_credit_card/credit_card_form.dart';
// // import 'package:flutter_credit_card/credit_card_model.dart';
// // import 'package:flutter_credit_card/credit_card_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class HomeView extends StatefulWidget {
//   HomeView({Key? key}) : super(key: key);
//
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   double bitcoin = 0.0;
//   double ethereum = 0.0;
//   double tether = 0.0;
//
//   // String cardNumber = '';
//   // String expiryDate = '';
//   // String cardHolderName = '';
//   // String cvvCode = '';
//   // bool isCvvFocused = false;
//   // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     getValues();
//   }
//
//   getValues() async {
//     bitcoin = await getCoinPrice("bitcoin");
//     ethereum = await getCoinPrice("ethereum");
//     tether = await getCoinPrice("tether");
//
//     setState(() {});
//   }
//
//   // void onCreditCardModelChange(CreditCardModel creditCardModel) {
//   //   setState(() {
//   //     cardNumber = creditCardModel.cardNumber;
//   //     expiryDate = creditCardModel.expiryDate;
//   //     cardHolderName = creditCardModel.cardHolderName;
//   //     cvvCode = creditCardModel.cvvCode;
//   //     isCvvFocused = creditCardModel.isCvvFocused;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     getValue(String id, double amount) {
//       if (id == "bitcoin") {
//         return bitcoin * amount;
//       } else if (id == "ethereum") {
//         return ethereum * amount;
//       } else {
//         return tether * amount;
//       }
//     }
//
//     //_signOutUser
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(color: Colors.white),
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 60, 150, 0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Welcome',
//                         style: GoogleFonts.inter(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 28),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 60, 20, 0),
//                     child: IconButton(
//                       icon: const Icon(Icons.settings_rounded),
//                       iconSize: 30,
//                       color: Colors.grey[600],
//                       onPressed: () {
//                         ModalBottomSheet.show(
//                             context: context, widget: SettingsPage());
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(
//                 color: Colors.grey[500],
//                 height: 10,
//               ),
//               Center(
//                 //display list of all the user's coins available
//                 child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('Users')
//                         .doc(FirebaseAuth.instance.currentUser!.uid)
//                         .collection('Coins')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//
//                       return Container(
//                         width: MediaQuery.of(context).size.width / 1.2,
//                         height: MediaQuery.of(context).size.height / 1.4,
//                         child: ListView(
//                           children: snapshot.data!.docs.map((document) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 5),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 height: MediaQuery.of(context).size.height / 12,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   color: Colors.grey[700],
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                           child: Text(
//                                             'Coin name: ${document.id}',
//                                             style: GoogleFonts.inter(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                           child: Text(
//                                             " Amount Owned: \$${getValue(document.id, document['Amount']).toStringAsFixed(2)}",
//                                             style: GoogleFonts.inter(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           ModalBottomSheet.show(context: context, widget: AddView());
//         },
//         child: Icon(Icons.add, color: Colors.grey[700]),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }
// //
// // CreditCardWidget(
// //   cardBgColor: Colors.redAccent[200],
// //   cardNumber: cardNumber,
// //   expiryDate: expiryDate,
// //   cardHolderName: cardHolderName,
// //   cvvCode: cvvCode,
// //   showBackView: isCvvFocused,
// //   obscureCardNumber: true,
// //   obscureCardCvv: true,
// // ),
// // Expanded(
// //   child: SingleChildScrollView(
// //     child: Column(
// //       children: [
// //         CreditCardForm(
// //           formKey: formKey,
// //           onCreditCardModelChange: onCreditCardModelChange,
// //           obscureCvv: true,
// //           obscureNumber: true,
// //           cardNumberDecoration: const InputDecoration(
// //             border: OutlineInputBorder(),
// //             labelText: 'Number',
// //             hintText: 'XXXX XXXX XXXX XXXX',
// //           ),
// //           expiryDateDecoration: const InputDecoration(
// //             border: OutlineInputBorder(),
// //             labelText: 'Expired Date',
// //             hintText: 'XX/XX',
// //
// //           ),
// //           cvvCodeDecoration: const InputDecoration(
// //             border: OutlineInputBorder(),
// //             labelText: 'CVV',
// //             hintText: 'XXX',
// //           ),
// //           cardHolderDecoration: const InputDecoration(
// //             border: OutlineInputBorder(),
// //             labelText: 'Card Holder Name',
// //           ),
// //         ),
// //         SizedBox(height: 20,),
// //         RaisedButton(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8.0),
// //           ),
// //           child: Container(
// //             margin: const EdgeInsets.all(8),
// //             child: const Text(
// //               'Validate',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 18,
// //               ),
// //             ),
// //           ),
// //           color: const Color(0xff1b447b),
// //           onPressed: () {
// //             if (formKey.currentState!.validate()) {
// //               print('valid!');
// //               AlertDialog(
// //                 backgroundColor: Color(0xff1b447b),
// //                 title: Text('Valid'),
// //                 content: Text(
// //                     'Your card has been successfully validated!'),
// //                 actions: [
// //                   FlatButton(
// //                       child: Text(
// //                         "Ok",
// //                         style: TextStyle(
// //                             fontSize: 18, color: Colors.cyan),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       }),
// //                 ],
// //               );
// //             } else {
// //               print('invalid!');
// //             }
// //           },
// //         )
// //       ],
// //     ),
// //   ),
// // ),
