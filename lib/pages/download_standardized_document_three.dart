import 'dart:typed_data';

import 'package:admin_block/pages/user_main.dart';
import 'package:admin_block/service/storage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentThree extends StatefulWidget {
  const DocumentThree({Key? key}) : super(key: key);
  @override
  _DocumentThreeState createState() => _DocumentThreeState();
}

class _DocumentThreeState extends State<DocumentThree> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    final url =
        "https://imgv2-2-f.scribdassets.com/img/document/288326596/original/0a8b11190c/1645305873?v=1";

    _save() async {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: "working-capital");
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
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    'lib/assets/images/download_jpg.png',
                    width: 280,
                    height: 240,
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.deepOrange,
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Text(
                          'To access the maintenance request you should click on the button below.',
                          style: GoogleFonts.mukta(
                            fontSize: 22,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.deepOrange,
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Text(
                          'The image will be saved in your local device directory.',
                          style: GoogleFonts.mukta(
                            fontSize: 22,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: getImage(context, 'working-capital.png'),
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
            FlatButton(
              color: Color(0xFFEEB162),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                _save();
              },
              child: Text(
                'working-capital.png',
                style: GoogleFonts.mukta(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
