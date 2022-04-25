import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SendDocs extends StatefulWidget {
  const SendDocs({Key? key}) : super(key: key);

  @override
  _SendDocsState createState() => _SendDocsState();
}

class _SendDocsState extends State<SendDocs> {
  bool useTempDirectory = true;
  List<String> attachment_list = <String>[];
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  Future<void> sendEmail(BuildContext context) async {
    final MailOptions mailOptions = MailOptions(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: <String>['administratie_bloc@gmail.com'],
      isHTML: true,
      ccRecipients: <String>['irina.t.gh.stefanescu@gmail.com'],
      attachments: attachment_list,
    );

    String platformResponse;

    try {
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      switch (response) {
        case MailerResponse.saved:
          platformResponse = 'Email was saved to draft!';
          break;
        case MailerResponse.sent:
          platformResponse = 'Email was sent!';
          break;
        case MailerResponse.cancelled:
          platformResponse = 'Email was cancelled!';
          break;
        case MailerResponse.android:
          platformResponse = 'Intent was success!';
          break;
        default:
          platformResponse = 'Unknown';
          break;
      }
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
      if (!mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Message',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(error.message ?? 'unknown error'),
            ],
          ),
          contentPadding: const EdgeInsets.all(26),
          title: Text(error.code),
        ),
      );
    } catch (error) {
      platformResponse = error.toString();
    }
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Email was sent successfully!'),
    ));
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget imagePath = GridView.count(
      primary: false,
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List<Widget>.generate(
        attachment_list.length,
        (int index) {
          final File file = File(attachment_list[index]);
          return GridTile(
            key: Key(attachment_list[index]),
            footer: GridTileBar(
              title: Text(
                file.path.split('/').last,
                textAlign: TextAlign.justify,
              ),
            ),
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.brown[700],
                      ),
                      child: Image.file(
                        File(attachment_list[index]),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.attachment,
                          size: 50,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    borderRadius: BorderRadius.circular(59),
                    color: Colors.brown[500],
                    child: IconButton(
                      tooltip: 'remove',
                      onPressed: () {
                        setState(() {
                          attachment_list.removeAt(index);
                        });
                      },
                      padding: const EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFFDD6A0),
                    Color(0xFFFC7970),
                  ],
                )),
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        'Send email to administration',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Color(0xCBFFFFFF),
                        elevation: 5,
                        shadowColor: Color(0xFFEC7648),
                        child: TextFormField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            labelText: 'Subject',
                            labelStyle: TextStyle(
                              color: Colors.brown,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Color(0xCDEFEDED),
                        elevation: 5,
                        shadowColor: Color(0xFFEC7648),
                        child: TextFormField(
                          controller: _bodyController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            labelText: 'Body...',
                            labelStyle: TextStyle(
                              color: Colors.brown,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () => sendEmail(context),
                            child: Text(
                              'Send email',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.double_arrow_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    imagePath,
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.brown[500],
            icon: const Icon(Icons.camera),
            label: const Text('Add attachments'),
            onPressed: _picker,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat),
    );
  }

  void _picker() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachment_list.add(pick.path);
      });
    }
  }

  Future<String> get _tempPath async {
    final Directory directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future<String> get _localAppPath async {
    final Directory directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final String path = await (useTempDirectory ? _tempPath : _localAppPath);
    return File('$path/$fileName.txt');
  }

  Future<File> writeFile(String text, [String fileName = '']) async {
    fileName = fileName.isNotEmpty ? fileName : 'fileName';
    final File file = await _localFile(fileName);

    return file.writeAsString('$text');
  }
}

class TempFile {
  TempFile({required this.name, required this.content});
  final String name, content;
}
