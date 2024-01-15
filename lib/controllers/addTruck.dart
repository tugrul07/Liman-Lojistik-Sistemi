import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

import '../detection/detect.dart';
import 'notifi_model.dart';


class truckEkle extends StatefulWidget {
  truckEkle(this.plateNumber);
  late String plateNumber;
  @override
  _truckEklestate  createState() =>  _truckEklestate ();
}

class _truckEklestate extends State<truckEkle> {


  final datacount = GetStorage();
  late String token;


  late String driverName;
  late String driverPhone;
  late double capacity;

  final String apiUrl = "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/trucks";


  Future<void> postData() async {
    Map<String, dynamic> data = {
      "plateNumber": widget.plateNumber,
      "driverName": driverName,
      "driverPhone": driverPhone,
      "capacity": capacity,
      "status": "UNLOADED",
    };

    try {
      if (datacount.read('token') != null) {
        setState(() {
          token = datacount.read('token');
        });
        print('Token is: $token');
      }
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print("Data posted successfully!");
        showCustomModal(context, 'Kamyon Başarıyla Eklendi!', false);
      } else {
        showCustomModal(context, 'Eklerken Hata oldu: ${response.statusCode}', true);
        print("Failed to post data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      showCustomModal(context, ' Hata Detayı: ${e}', true);
      print("Error: $e");
    }
  }



  TextEditingController _plateNumberController = TextEditingController();
 // Replace with your initial value

  @override
  void initState() {
    super.initState();
    _plateNumberController.text = widget.plateNumber;
  }

  @override
  void dispose() {
    _plateNumberController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              IconButton(onPressed: (){Navigator.pop(context);},
                  icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#4C4959"),)),

              Text(
                "Araç bilgileri",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 24,
                      letterSpacing: .5,fontWeight: FontWeight.w700),
                ),
              ),




              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child:Text(
                      "Araç Plakası",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    ),


              ),


              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SizedBox( // Add a SizedBox to enforce height constraint
                  height: 35, // Adjust the height as needed
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _plateNumberController,
                          onChanged: (value) {
                            setState(() {
                              widget.plateNumber = value;
                            });
                          },
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: HexColor("#343B55"),
                              fontSize: 18,
                              letterSpacing: .5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: HexColor("#343B55"),
                                fontSize: 18,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            hintText: "Araç Plakası",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Detect(1)),
                          );
                        },
                        icon: Icon(CupertinoIcons.camera_viewfinder, color: HexColor("#41D6B3")),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sürücü Adı",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)), // set border radius here

                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"), // set border color here
                    width: 1.4, // set border width here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: TextField(
                  onChanged: (value){
                    setState(() {
                      driverName = value;
                    });
                  },


                  style:GoogleFonts.roboto(
                    textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.roboto(
                      textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    hintText:  "Sürücü Adı",
                    border: InputBorder.none,



                  ),


                ),
              ),


              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Telefon Numarası",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)), // set border radius here

                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"), // set border color here
                    width: 1.4, // set border width here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: TextField(
                  onChanged: (value){
                    setState(() {
                      driverPhone = value;
                    });
                  },


                  style:GoogleFonts.roboto(
                    textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.roboto(
                      textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    hintText: "Telefon Numarası",
                    border: InputBorder.none,



                  ),


                ),
              ),



              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "kapasite",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)), // set border radius here

                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"), // set border color here
                    width: 1.4, // set border width here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: TextField(
                  onChanged: (value){
                    setState(() {
                      capacity = double.parse(value);
                    });
                  },


                  style:GoogleFonts.roboto(
                    textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.roboto(
                      textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    hintText: "kapasite",
                    border: InputBorder.none,



                  ),


                ),
              ),






              SizedBox(height: 20,),

              Container(
                width:350,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],



                ),
                child:CupertinoButton(


                    borderRadius: BorderRadius.circular(22.0),
                    padding: EdgeInsets.all(15),

                    color:HexColor("#41D6B3"),
                    child:Text(

                      "Arabayı Ekle",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white,fontSize: 18,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),

                    ), onPressed: (){

                  postData();


                }),
              ),



            ],
          ),
        ),
      ),
    );





  }

}
