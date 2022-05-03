import 'package:admin_block/pages/blink_element.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final double minScale = 1;
  final double maxScale = 4;

  TransformationController controller = TransformationController();
  Animation<Matrix4>? animation;

  @override
  initState() {
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
        ],
      ),
    );
  }
}
