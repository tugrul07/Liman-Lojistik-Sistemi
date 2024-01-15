import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:regexpattern/regexpattern.dart';

import '../controllers/addTruck.dart';
import '../controllers/newJob.dart';




class Detect extends StatefulWidget {
   Detect(this.switcher);
  late int switcher;


  @override
  State<Detect> createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child:IconButton(onPressed: (){FocusScope.of(context).unfocus();
              Navigator.pop(context);
              },
                  icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#1C1A1A"),)),
            ),
              ScalableOCR(

                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 102, 160, 241),
                  boxLeftOff: 5,
                  boxBottomOff: 2.5,
                  boxRightOff: 5,
                  boxTopOff: 2.5,
                  boxHeight: MediaQuery.of(context).size.height / 1.5,
                  getRawData: (value) {
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }),
              StreamBuilder<String>(
                stream: controller.stream,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  print("Snapshot data: ${snapshot.data}");
                  return Result(
                   snapshot.data != null ? snapshot.data! : "Lütfen Plakayı Gösterin",
                    widget.switcher,
                  );
                },
              )

            ],
          ),
        ));
  }
}



class Result extends StatelessWidget {
  const Result(
     this.text,
     this.switcher,
  );

  final String text;
  final int switcher;

  @override
  Widget build(BuildContext context) {

    String extractTurkishCarPlate(String input) {
      RegExp plateRegExp = RegExp(r'\b\d{1,4}\s?[A-Z]{1,3}\s?\d{1,4}\b');
      // Regular expression pattern for Turkish car plates

      String plate = plateRegExp.stringMatch(input) ?? "Araç Plakası Bulunmadı";
      // Use the regular expression to find the car plate in the input string

      return plate;
    }
    String extractedPlate = extractTurkishCarPlate(text);

    String extractContainerPlate(String input) {
      RegExp plateRegExp = RegExp(r'\b[A-Z]{4}\s?\d{3}\s?\d{3}\s?\d\b');
      // Regular expression pattern for container plates

      String plate = plateRegExp.stringMatch(input) ?? "Konteyner Plakası Bulunmadı";
      // Use the regular expression to find the container plate in the input string

      return plate;
    }

    String extractedPlateContainer = extractContainerPlate(text);


    return Column(
      children: [
        Text(
          switcher == 1 ? extractedPlate : extractedPlateContainer,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              letterSpacing: .5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CupertinoButton(
          borderRadius: BorderRadius.circular(22.0),
          padding: EdgeInsets.all(15),
          color: HexColor("#41D6B3"),
          child: Text(
            "Konteyner Numarası Doğrudur",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onPressed: () async {


            if (switcher == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => truckEkle(extractedPlate),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addJob(extractedPlateContainer),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
