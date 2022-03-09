import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendDocs extends StatefulWidget {
  const SendDocs({Key? key}) : super(key: key);

  @override
  _SendDocsState createState() => _SendDocsState();
}

class _SendDocsState extends State<SendDocs> {

  final _formKeySendDocs = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKeySendDocs,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                'Send documents',
                style: GoogleFonts.mukta(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "In order to send requests to the \nadministration, "
                      "please fill in the form \nbelow and attach the desired files.",
                  style: GoogleFonts.mukta(
                    fontSize: 22,
                    color: Colors.black26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Receiver',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFFC9979),
                    filled: true,
                    focusColor: Color(0xFFFC9979),
                    hoverColor: Color(0x70D58972),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  controller: emailController,
                  validator: (value){
                    if (value == null || value.isEmpty)
                    {
                      return 'Please provide email address';
                    }
                    else if (!value.contains('@')){
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
