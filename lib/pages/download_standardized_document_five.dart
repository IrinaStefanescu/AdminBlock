import 'dart:typed_data';

import 'package:admin_block/components/button_primary.dart';
import 'package:admin_block/pages/service/notifications_api.dart';
import 'package:admin_block/user/dashboard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void listenNotifications() => NotificationApi.onNotificationsCallback.stream
      .listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      NotificationApi.cancelAllUserNotifications();

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final url =
        "data:image/png;base64,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";

    _save() async {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: "owners-association");
        print(result);

        NotificationApi.showNotification(
          title: "AdminBlock Notification",
          body:
              "Request to get an owners association application downloaded to local storage!",
          payload: "document5",
        );
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
                  height: 180,
                  color: Colors.white,
                  child: Image.asset(
                    'lib/assets/images/download_jpg.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: 180,
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
                              'This is a request to get \nan owners association \napplication.',
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
              future: getImage(context, 'owners-association.png'),
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
                title: 'owners-association.png',
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
