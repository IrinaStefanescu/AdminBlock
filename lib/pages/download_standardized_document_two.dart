import 'dart:typed_data';

import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/user/dashboard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentTwo extends StatefulWidget {
  const DocumentTwo({Key? key}) : super(key: key);
  @override
  _DocumentTwoState createState() => _DocumentTwoState();
}

class _DocumentTwoState extends State<DocumentTwo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final url =
        "https://imgv2-1-f.scribdassets.com/img/document/36206655/original/3ade4fcc21/1645519679?v=1";

    _save() async {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: "meter-reading");
        print(result);
      }
    }

    Future<Widget> getImage(BuildContext context, String imageName) async {
      late Image image;
      await FireStorageServiceApi.loadImage(context, imageName).then((value) {
        image = Image.network(
          value.toString(),
          fit: BoxFit.fill,
        );
      });
      return image;
    }

    return Material(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                    ),
                    Text(
                      'Dashboard',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 170,
                  color: Colors.white,
                  child: Image.asset(
                    'lib/assets/images/download_jpg.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: 170,
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 4,
              child: ListView(
                children: [
                  CarouselSlider(
                    carouselController: _controller,
                    items: [
                      //1st Image of Slider
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.deepOrange,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'This is a request to get \na meter reading form.',
                              style: GoogleFonts.mukta(
                                fontSize: 20,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.deepOrange,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'To access the maintenance \nrequest you should click on \nthe button below.',
                              style: GoogleFonts.mukta(
                                fontSize: 20,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.deepOrange,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'The image will be saved in \nyour local device directory.',
                              style: GoogleFonts.mukta(
                                fontSize: 20,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                        height: 160.0,
                        autoPlay: false,
                        reverse: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0, 1, 2].map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry),
                          child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry
                                      ? Colors.grey[900]
                                      : Colors.grey[200])),
                        );
                      }).toList())
                ],
              ),
            ),
            FutureBuilder(
              future: getImage(context, 'meter-reading.jpg'),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 5,
                    child: snapshot.data,
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.width / 15,
                    child: CircularProgressIndicator(),
                  );
                }

                return Container();
              },
            ),
            SizedBox(
              height: 20,
            ),
            ButtonPrimary(
                title: 'meter-reading.jpg',
                action: _save,
                fontSize: 17,
                fontColor: Colors.white,
                fontWeight: FontWeight.w300,
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey.shade900,
                margin: EdgeInsets.fromLTRB(32, 0, 32, 20),
                borderRadius: BorderRadius.circular(12.0),
                borderSideColor: Colors.grey.shade900),
          ],
        ),
      ),
    );
  }
}

class FireStorageServiceApi extends ChangeNotifier {
  FireStorageServiceApi();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance
        .ref("documents/")
        .child(image)
        .getDownloadURL();
  }
}
