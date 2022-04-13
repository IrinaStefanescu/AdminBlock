import 'dart:typed_data';

import 'package:admin_block/pages/user_main.dart';
import 'package:admin_block/service/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentFive extends StatefulWidget {
  const DocumentFive({Key? key}) : super(key: key);
  @override
  _DocumentFiveState createState() => _DocumentFiveState();
}

class _DocumentFiveState extends State<DocumentFive> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    final url =
        "https://www.factura-fiscala.com/wp-content/uploads/2020/07/cerere-introduce-persoane-la-intretinere.jpg";

    _save() async {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: "document5");
        print(result);
      }
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
            SizedBox(
              height: 30,
            ),
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
              height: MediaQuery.of(context).size.height / 3,
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
                  SizedBox(
                    height: 20,
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
            // ElevatedButton(
            //   onPressed: () async {
            //     final result = await FilePicker.platform.pickFiles(
            //       allowMultiple: false,
            //       type: FileType.custom,
            //       allowedExtensions: ['png', 'jpg'],
            //     );
            //
            //     if (result == null){
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('No file selected'),),
            //       );
            //       return null;
            //     }
            //
            //     final path = result.files.single.path;
            //     final fileName = result.files.single.name;
            //
            //     print(path);
            //     print(fileName);
            //
            //     storage.uploadFile(path!, fileName).then((value) => print('Done'),);
            //   },
            //   child: Text('Upload file'),
            // ),
            FutureBuilder(
                future: storage.downloadURL('document5.jpg'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: MediaQuery.of(context).size.width / 7,
                      child: RaisedButton(
                        color: Color(0xFFEEB162),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          _save();
                        },
                        child: Text(
                          'document5.jpg',
                          style: GoogleFonts.mukta(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    );
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
