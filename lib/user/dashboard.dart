import 'package:admin_block/pages/download_standardized_document_five.dart';
import 'package:admin_block/pages/download_standardized_document_four.dart';
import 'package:admin_block/pages/download_standardized_document_one.dart';
import 'package:admin_block/pages/download_standardized_document_six.dart';
import 'package:admin_block/pages/download_standardized_document_three.dart';
import 'package:admin_block/pages/download_standardized_document_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final double minScale = 1;
  final double maxScale = 4;

  TransformationController controller = TransformationController();
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              height: MediaQuery.of(context).size.height / 14,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Calculate your maintenance',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Standardized applications',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFEC936E),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentOne()));
                        },
                        child: Center(
                          child: Text(
                            'Remove person from house-keeping',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF795C48),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentTwo()));
                        },
                        child: Center(
                          child: Text(
                            'Meter reading form',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFEE882F),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentThree()));
                        },
                        child: Center(
                          child: Text(
                            'Returning working capital',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF993737),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentFour()));
                        },
                        child: Text(
                          'Sale-purchase certificate',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0x88A56333),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentFive()));
                        },
                        child: Text(
                          'Owners association application',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFE7C878),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentSix()));
                        },
                        child: Text(
                          'Add person for house-keeping',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Complaints',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                  color: Color(0xFFAC4B32),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Complaints related to neighbours',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
