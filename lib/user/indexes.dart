import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Indexes extends StatefulWidget {
  const Indexes({Key? key}) : super(key: key);

  @override
  State<Indexes> createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> {
  var coldWater = "";

  final TextEditingController _coldWaterController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                      controller: _coldWaterController,
                      decoration: const InputDecoration(
                        fillColor: Color(0x70E0E0E0),
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        labelText: '     3',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onChanged: (value) {
                        coldWater = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ))),
    );
  }
}
