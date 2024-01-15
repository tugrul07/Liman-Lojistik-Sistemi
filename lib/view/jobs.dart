import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import '../controllers/job_details.dart';

import '../controllers/notifi_model.dart';
import 'package:flutter/services.dart';



class jobs extends StatefulWidget {

  @override
  _jobsstate createState() => _jobsstate();
}

class _jobsstate extends State<jobs> {



  final String apiUrl = "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/tickets";
  final datacount = GetStorage();

  late String token;
  List<Map<String, dynamic>> _jobs_Data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
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
        List<dynamic> truckList = jsonDecode(response.body);
        setState(() {
          _jobs_Data = List<Map<String, dynamic>>.from(truckList);
        });
      } else {
        throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {


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
                IconButton(onPressed: (){Navigator.pop(context);    FocusScope.of(context).unfocus();},
                    icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#4C4959"),)),
                Text(
                  "İşleriniz",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: HexColor("#4B5256"),fontSize: 24,
                        letterSpacing: .2,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            Container(
                height:500,
                child:
                _jobs_Data.length >0 ? ListView.builder(
                  itemCount: _jobs_Data.length,
                  itemBuilder: (context, index) {
                    return theme(
                        _jobs_Data[index]['isInvoiceCreated'],
                        _jobs_Data[index]['entryTime'],
                        _jobs_Data[index]['id'],
                        token
                    );
                  },
                )
                    :warning("Her Hangi Bir İş Bulnmadı.",Icon(
                  Icons.warning_rounded ,
                  color:Colors.amber ,
                  size: 30,
                ),)

            ),








          ],
        ),
      ),
    );





  }

}


class theme extends StatelessWidget{

  late String ticketID;
  late String entryTime;
  late bool isInvoiceCreated;
  late String token;

  theme(this.isInvoiceCreated,this.entryTime,this.ticketID,this.token);



  @override
  Widget build(BuildContext context) {

    DateTime dateTime = DateTime.parse(entryTime);
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return  GestureDetector(
      onTap: ()    {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => jobs_details(ticketID)),
        );



      },

      child:Container(
        height: 70,
        margin: EdgeInsets.only(bottom: 20),

        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: HexColor("#F6F7FE"),
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.05,
              blurRadius: 1,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],





        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          Container(
            child:  Row(children: [
              Image.network("https://img.icons8.com/fluency/96/new-job.png",width: 50,height: 50,),
              SizedBox(width: 9,),
              Text(
                formattedDate,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: HexColor("#343B55"),
                    fontSize: 22,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],),
          ),
            Container(
              height: 70,
              width: 40,



              decoration: BoxDecoration(
                color: HexColor("#41D6B3"),


                borderRadius: BorderRadius.circular(7),
              ),

              child:Icon(Icons.arrow_forward_ios,color:Colors.white,size: 30,),
            ),




          ],
        ),
      ),
    );
  }

}
