import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

void showCustomModal(BuildContext context, String message, bool isError) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return _buildContent(message, isError);
    },
  );
}

Widget _buildContent(String message, bool isError) {
  return Container(

    height: 100,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                color: HexColor("#021032"),
                fontSize: 14,
                letterSpacing: .5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(
            isError ? CupertinoIcons.xmark_circle_fill : CupertinoIcons.checkmark_circle_fill,
            color: isError ? Colors.redAccent : Colors.green,
            size: 30,
          ),
        ],
      ),
    ),
  );
}

class warning extends StatelessWidget{
  late String msj;
  late Icon warningIcon;
  warning(this.msj,this.warningIcon);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msj,
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    color: HexColor("#021032"),
                    fontSize: 19,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              warningIcon

            ],
          ),
        ),

    );
  }

}