import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../detection/detect.dart';
import 'notifi_model.dart';





class addJob extends StatefulWidget {
  addJob(this.containerNumber);
  late String containerNumber;

  @override
  _addJobstate createState() => _addJobstate();
}
final datacount = GetStorage();

class _addJobstate extends State<addJob> {



  final datacount = GetStorage();
  late String token;

  Map<String, String>  truckPlateNumbers = {};
  String? selectedTruck;
  String? selectedTruckID;


  Map<String, String> organizationMap = {};
  String? selectedOrgani;
  String? selectedOrganiID;


  TextEditingController _plateNumberController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchData();
    _plateNumberController.text = widget.containerNumber;
  }


  @override
  void dispose() {
    _plateNumberController.dispose();
    super.dispose();
  }


  Future<void> fetchData() async {
    if (datacount.read('token') != null) {
      setState(() {
        token = datacount.read('token');
      });
      print('Token is: $token');
    }

    final response1 = await http.get(
      Uri.parse("http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/trucks"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final truckData = json.decode(response1.body);


    final response2 = await http.get(
      Uri.parse("http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/organizations"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final organizationsData = json.decode(response2.body);

    setState(() {

      for (var truckJSON in truckData) {
        String id = truckJSON['id'];
        String name = truckJSON['plateNumber'];
        truckPlateNumbers[name] = id;
      }

      for (var organizationJson in organizationsData) {
        String id = organizationJson['id'];
        String name = organizationJson['name'];
        organizationMap[name] = id;
      }
    });
  }





  TextEditingController entryTimeController = TextEditingController();
  TextEditingController exitTimeController = TextEditingController();

  DateTime selectedEntryTime = DateTime.now();
  DateTime selectedExitTime = DateTime.now();

  Future<void> addTicket() async {
    final datacount = GetStorage();
    final token = datacount.read('token');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final newTicket = {

      "containerNumber": widget.containerNumber,
      "truckId": selectedTruckID,
      "organizationId": selectedOrganiID,
      "entryTime": selectedEntryTime.toUtc().toIso8601String(),
      "exitTime": selectedExitTime.toUtc().toIso8601String(),

      "facilityId": "d144514c-f059-4f79-afc0-af382cbec7ad",
      "isInvoiceCreated": false,

    };
    try {
      final response = await http.post(
        Uri.parse(
            "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/tickets"),
        headers: headers,
        body: json.encode(newTicket),
      );

      if (response.statusCode == 201) {
        print("Ticket added successfully");
        showCustomModal(context, 'Yeni İş Başarıyla Eklendi!', false);
      } else {
        print("Error adding ticket - Status Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        showCustomModal(context, 'Lütfen Bütün Boşlukları doldurun.', true);
        // Handle error, show an error message, etc.
      }
    }catch (e) {
      showCustomModal(context, ' Hata Detayı: ${e}', true);
      print("Error: $e");
    }
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

              IconButton(onPressed: (){    FocusScope.of(context).unfocus();
                Navigator.pop(context);},
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
                child: Text(
                  "Araç Plakası ",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                width: 350,


                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"), // set border color here
                    width: 1.0, // set border width here
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here



                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],



                ),
                child:DropdownButton<String>(
                  value: selectedTruck,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTruck = newValue;
                      selectedTruckID = truckPlateNumbers[selectedTruck];
                    });
                  },
                  items: truckPlateNumbers.keys.map<DropdownMenuItem<String>>(
                        (String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(
                          name,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                                color: HexColor("#343B55"),
                                fontSize: 16,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  hint: Text(
                    'Araba Seç',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: HexColor("#343B55"),
                          fontSize: 16,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),




              ),

              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Firma ",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#343B55"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                width: 350,


                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: HexColor("#E2E3E7"), // set border color here
                    width: 1.0, // set border width here
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here



                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],



                ),

                child:  DropdownButton<String>(
                  value: selectedOrgani,
                  onChanged: (newValue) {
                    setState(() {
                      selectedOrgani = newValue;
                      selectedOrganiID = organizationMap[selectedOrgani];
                    });
                  },
                  items: organizationMap.keys.map<DropdownMenuItem<String>>(
                        (String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(
                          name,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                                color: HexColor("#343B55"),
                                fontSize: 16,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  hint: Text(
                    'Firma Seç',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: HexColor("#343B55"),
                          fontSize: 16,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),




              ),
              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Varış Birimi ",
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

                child:TextField(
                  readOnly: true,
                  controller: entryTimeController,
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
                    hintText: '',
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: HexColor("#343B55"),
                      fontSize: 18,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedEntryTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedEntryTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedEntryTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          entryTimeController.text =
                              DateFormat("yyyy-MM-dd HH:mm:ss").format(selectedEntryTime); // Change format here
                        });
                      }
                    }
                  },
                )

              ),


              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Çıkış Birimi ",
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
                  readOnly: true,
                  controller: exitTimeController,
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
                    hintText: '',
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: HexColor("#343B55"),
                      fontSize: 18,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedExitTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedExitTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedExitTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          exitTimeController.text =
                              DateFormat("yyyy-MM-dd HH:mm:ss").format(selectedExitTime); // Change format here
                        });
                      }
                    }
                  },
                )

              ),



              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Konteyner Numarası",
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
                              widget.containerNumber = value;
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
                            hintText: "Konteyner Numarası",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Detect(0)),
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

                      "Yeni İş Ekle",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white,fontSize: 18,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),

                    ), onPressed: ()async{
                  await addTicket();


                }),
              ),



            ],
          ),
        ),
      ),
    );





  }

}
