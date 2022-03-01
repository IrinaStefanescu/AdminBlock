// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// class Documents extends StatefulWidget {
//   const Documents({Key? key}) : super(key: key);
//
//   @override
//   _DocumentsState createState() => _DocumentsState();
// }
//
// class _DocumentsState extends State<Documents> {
//
//   static Future imageURL(BuildContext context, String filePath) async {
//     return await FirebaseStorage.instance
//         .ref()
//         .child('documents/$filePath')
//         .getDownloadURL();
//   }
//
//   static Future<Widget> getImage(BuildContext context, String theImage) async {
//     late Image m;
//     await imageURL(context, theImage).then((downloadURL) {
//       m = Image.network(
//         downloadURL.toString(),
//         fit: BoxFit.cover,
//       );
//     });
//     return m;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.only(top: 200.0),
//           child: Container(
//             width: 200,
//             height: 200,
//             color: Colors.yellow,
//             child: FutureBuilder(
//               future: getImage(context, 'document1.png'),
//               builder: (context, snapshot){
//                 if (snapshot.hasError) {
//                   return Text("Something went wrong");
//                 }
//
//                 if (!snapshot.hasData) {
//                   return Text("Document does not exist");
//                 }
//                 if (snapshot.connectionState == ConnectionState.done){
//                   return Container(
//                     width: MediaQuery.of(context).size.width / 1.2,
//                     height: MediaQuery.of(context).size.height / 1.2,
//
//                   );
//                 }
//                 return const SizedBox();
//               },
//               ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //take url and return dynamic image
// class FireStorageService extends ChangeNotifier {
//   FireStorageService();
//   static Future<dynamic> loadImage(BuildContext context, String Image) async{
//     return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
//   }
// }
import 'package:admin_block/service/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);
  @override _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {

  @override
  Widget build(BuildContext context) {

    final Storage storage = Storage();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height / 3,
        height: 200,
        child: Column(
          children: [
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );

                if (result == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No file selected'),),
                  );
                  return null;
                }

                final path = result.files.single.path;
                final fileName = result.files.single.name;

                print(path);
                print(fileName);

                storage.uploadFile(path!, fileName).then((value) => print('Done'),);
              },
              child: Text('Upload file'),
            ),

            FutureBuilder(
              future: storage.downloadURL('document1.jpg'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: Image.network(snapshot.data!, fit: BoxFit.cover,),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return Container();
              }),
          ],
        ),
      ),

    );
  }
}
