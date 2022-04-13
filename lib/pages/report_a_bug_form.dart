import 'package:admin_block/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({Key? key}) : super(key: key);

  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  late bool _isCheckedTC;
  late TextEditingController _phoneNumberController;
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    _isCheckedTC = false;
    _phoneNumberController = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey[900];
    }
    return Colors.grey[900];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                }),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Report a Bug',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
        backgroundColor: Color(0xF5F3A866),
        shadowColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 5))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Text(
                'Report a bug or issue in the mobile app',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 35, top: 10, bottom: 40, right: 40),
              child: Text(
                'Use this form to report any bugs you encounter with the Admin Block Android mobile app.',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Email',
                      style: GoogleFonts.inter(
                        color: Colors.grey[900],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' *',
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 10, 40, 0),
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey[700],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Color(0xFF86899A),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Color(0xFF86899A),
                    ),
                  ),
                ),
                onSubmitted: (String value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 30, 10, 0),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          'My issue is: Please share details like phone,\nOS version, device screen size etc ',
                      style: GoogleFonts.inter(
                        color: Colors.grey[900],
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 10, 40, 0),
              child: TextField(
                controller: _bodyController,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Body...',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Color(0xFF86899A))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Color(0xFF86899A))),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[700],
                ),
                child: MaterialButton(
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () async {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
