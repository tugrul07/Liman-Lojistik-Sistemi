import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

import '../controllers/notifi_model.dart';
import 'package:flutter/services.dart';
import '../controllers/addTruck.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  trucks(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class trucks extends StatefulWidget {
    trucks({Key? key}) : super(key: key);

  @override
  _trucksstate createState() => _trucksstate();
}

class _trucksstate extends State<trucks> {



  final String apiUrl = "http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/trucks";
  final datacount = GetStorage();

  late String token;
  List<Map<String, dynamic>> _truckData = [];

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
          _truckData = List<Map<String, dynamic>>.from(truckList);
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
                IconButton(onPressed: (){Navigator.pop(context);  FocusScope.of(context).unfocus(); },
                    icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#4C4959"),)),
                Text(
                  "Araçlarınız",
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
                _truckData.length >0 ? ListView.builder(
                  itemCount: _truckData.length,
                  itemBuilder: (context, index) {
                    return theme(_truckData[index]['plateNumber'],_truckData[index]['id'],token);
                  },
                )
              :warning("Lütfen Bir araba ekleyin.",Icon(
                  Icons.warning_rounded ,
                  color:Colors.amber ,
                  size: 30,
                ),)

            ),



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

                    "Araba Ekle",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white,fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),

                  ), onPressed: (){

                          if( _truckData.length>10){
                            showCustomModal(context, 'Bir Arabadan fazla ekleyemiyorsun!', true);
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => truckEkle(" ")),
                            );
                          }

              }),
            ),




          ],
        ),
      ),
    );





  }

}


class theme extends StatelessWidget{
  late String truckPlate;
  late String truckID;
  late String token;
  theme(this.truckPlate,this.truckID,this.token);


  Future<void> deleteTruck(String truckId, String accessToken) async {
    final String apiUrl = 'http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/trucks/$truckId';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken', // Include the access token in the headers
    };

    try {
      final response = await http.delete(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        print('Truck deleted successfully.');
      } else {
        print('Failed to delete truck. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting truck: $e');
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Onayla'),
          content: Text('Kamyonu silmek istiyor musunuz?'),
          actions: <Widget>[
            TextButton(

              onPressed: () {
                Navigator.of(context).pop(false); // Return false when cancel is pressed
              },
              child: Text('İptal et',style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.black,fontSize: 15,
                    letterSpacing: .5,fontWeight: FontWeight.w600),
              ),),
            ),
            TextButton(


                onPressed: () async{
                  if (token.isNotEmpty) {
                    await deleteTruck(truckID, token);
                    Navigator.of(context).pop(false);
                    showCustomModal(context,"Araba Başarıyla Silindi",false);
                  } else {
                    Navigator.of(context).pop(false);
                    showCustomModal(context,"Erişim belirteci bulunamadı. Lütfen giriş yapın",true);
                   }
          // Return true when confirm is pressed
              },
              child: Text('Onaylıyorum', style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.red,fontSize: 18,
                    letterSpacing: .5,fontWeight: FontWeight.w600),
              ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: ()    {

        _showConfirmationDialog(context);



      },

      child:Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: HexColor("#47D1B8"),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            bottomRight: Radius.circular(26),
            bottomLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],





        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Container(
              child: Text(
                truckPlate,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color:Colors.white,fontSize: 24,
                      letterSpacing: .2,fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Image.network("https://img.icons8.com/ios/100/semi-truck-side-view.png",color:Colors.white70,width: 100,height: 100,)



          ],
        ) ,
      ),
    );
  }

}
