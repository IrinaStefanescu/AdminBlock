import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalBottomSheet {
  static show({
    required BuildContext context,
    required Widget widget,
    Color headerColor = const Color(0xFF424242),
    bool isTransparent = false,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            widget,
            Material(
              type: MaterialType.transparency,
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width,
                color: headerColor.withOpacity(isTransparent ? 0.0 : 1.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child: FittedBox(
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
