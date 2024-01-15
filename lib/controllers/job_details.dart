import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

import 'notifi_model.dart';



class jobs_details extends StatefulWidget {
  late String ticketID;
  jobs_details(this.ticketID);

  @override
  _jobs_detailsstate createState() => _jobs_detailsstate(ticketID);
}

class _jobs_detailsstate extends State<jobs_details> {
  late String ticketID;
  _jobs_detailsstate(this.ticketID);

  final datacount = GetStorage();

  late String token;
  List<Map<String, dynamic>> _jobData = [];

   String truckPlate = "";
   String  organizationName ="";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String apiUrl =
        "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/tickets/$ticketID";

    try {
      if (datacount.read('token') != null) {
        setState(() {
          token = datacount.read('token');
        });
        print('Token is: $token');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _jobData.add(responseData);
        });

        final organizationId = _jobData[0]['organizationId'];
        print(organizationId);
        final truckId = _jobData[0]['truckId'];

        final organizationData = await fetchOrganizationData(organizationId);
        final truckData = await fetchTruckData(truckId);
        setState(() {

          truckPlate = truckData['plateNumber'];
          organizationName = organizationData['name'];
        });



      } else {
        throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Map<String, dynamic>> fetchOrganizationData(String organizationId) async {
    final String apiUrl = "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/organizations/$organizationId";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Pass the token here
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch organization data. Status code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchTruckData(String truckId) async {
    final String apiUrl = "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/trucks/$truckId";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Pass the token here
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {

      throw Exception("Failed to fetch truck data. Status code: ${response.statusCode}");

    }
  }




  Future<void> updateTicketIsInvoiced(String ticketID, bool isInvoiced) async {
    final datacount = GetStorage();
    final token = datacount.read('token');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final updateData = {
      "isInvoiceCreated": isInvoiced,
    };

    try {
      final response = await http.patch(
        Uri.parse("http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/tickets/$ticketID"),
        headers: headers,
        body: json.encode(updateData),
      );

      if (response.statusCode == 200) {
        print("Ticket updated successfully");
        showCustomModal(context, ' Fatura Kesildi.', false);
        // Handle success, show a message, etc.
      } else {
        print("Error updating ticket - Status Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        showCustomModal(context, ' Lütfen Sonra deneyin', true);

        // Handle error, show an error message, etc.
      }
    } catch (e) {
      showCustomModal(context, ' Hata Detayı: ${e}', true);
      print("Error: $e");
      // Handle error, show an error message, etc.
    }
  }


  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(_jobData[0]['entryTime']);
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return Scaffold(
      body:Container(
        margin: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),

            Row(
              children: [
                IconButton(onPressed: (){Navigator.pop(context);},
                    icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#4C4959"),)),
                Text(
                  "İşin Bilgileri",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: HexColor("#4B5256"),fontSize: 24,
                        letterSpacing: .2,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40,),




            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:  HexColor("#CEEBF4"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                  bottomLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),




              ),

                    child: Text(
                      organizationName,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: HexColor("#042a14"),fontSize: 24,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    ),

            ),



            SizedBox(height: 40,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: HexColor("#b1eef2"),
                    borderRadius: BorderRadius.all(Radius.circular(15),),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Icon(CupertinoIcons.creditcard,size: 40,),

                      Text(
                        _jobData[0]['containerNumber'],
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color:HexColor("#042a14"),fontSize: 18,
                              letterSpacing: .2,fontWeight: FontWeight.w700),
                        ),
                      ),


                    ],
                  ),


                ),

                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: HexColor("#FFec99"),
                    borderRadius: BorderRadius.all(Radius.circular(15),),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Icon(CupertinoIcons.timer_fill,size: 40,),

                      Text(
                        formattedDate,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color:HexColor("#042a14"),fontSize: 18,
                              letterSpacing: .2,fontWeight: FontWeight.w700),
                        ),
                      ),


                    ],
                  ),


                ),

              ],
            ),

            SizedBox(height: 40,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: HexColor("#b2f2bb"),
                    borderRadius: BorderRadius.all(Radius.circular(15),),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Icon(Icons.fire_truck_outlined,size: 40,),

                      Text(
                        truckPlate,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color:HexColor("#042a14"),fontSize: 18,
                              letterSpacing: .2,fontWeight: FontWeight.w700),
                        ),
                      ),


                    ],
                  ),


                ),

                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:  _jobData[0]['isInvoiceCreated'] == true ? HexColor("#c7ffcc"):  HexColor("#ffc9c9"),
                    borderRadius: BorderRadius.all(Radius.circular(15),),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Icon(CupertinoIcons.doc_text_fill,size: 40,),

                      Text(
                        _jobData[0]['isInvoiceCreated'] == true ? "Kesildi":  "Kesilmedi",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color:HexColor("#042a14"),fontSize: 18,
                              letterSpacing: .2,fontWeight: FontWeight.w700),
                        ),
                      ),


                    ],
                  ),


                ),

              ],
            ),

            SizedBox(height: 20,),
            Container(
              width:350,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(22.0),




              ),
              child: _jobData[0]['isInvoiceCreated'] == true ?  null:  CupertinoButton(

                  borderRadius: BorderRadius.circular(22.0),
                  padding: EdgeInsets.all(15),

                  color:HexColor("#d74242"),
                  child:Text(

                    "Bittir",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white,fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),

                  ), onPressed: ()async{

                await updateTicketIsInvoiced(ticketID,true);


              }
              ),
            ),




          ],
        ),
      ),
    );





  }

}
