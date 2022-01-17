//import 'package:crypto_wallet_licenta/auth/login.dart';
import 'package:crypto_wallet_licenta/pages/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print("Something went wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        return Scaffold(
          body: OnBoardingUser(),
        );
      }
    );
  }
}


