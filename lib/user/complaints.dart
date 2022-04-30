import 'package:admin_block/pages/user_main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2023),
      builder: (context, child) => Theme(
        child: child!,
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.deepOrange,
            onPrimary: Colors.white,
            surface: Colors.deepOrange,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
      ),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserMain()));
                }),
            Text(
              "Dashboard",
              style: GoogleFonts.mukta(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  'Complete complaint',
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  'Open the calendar and choose the date \nthe incident happened.',
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 60,
                decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.orange),
                      left: BorderSide(width: 2.0, color: Colors.orange),
                      right: BorderSide(width: 2.0, color: Colors.orange),
                      bottom: BorderSide(width: 2.0, color: Colors.orange),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        _selectedDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today_outlined),
                      tooltip: 'Tap to open calendar',
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
