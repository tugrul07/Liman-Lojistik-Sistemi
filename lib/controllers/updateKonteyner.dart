import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const updateKonteyner(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class updateKonteyner extends StatefulWidget {
  const updateKonteyner({Key? key}) : super(key: key);

  @override
  _updateKonteynerstate createState() => _updateKonteynerstate();
}

class _updateKonteynerstate extends State<updateKonteyner> {

  List<String> countries = ["31 WD 3450", "53 FAD 324", "34 OF 340", "07 JKD 2356"];
  var seen = Set<String>();
  List<String> uniquelist = [];

  late String _selectedCountry;

  List<String> trucks = ["Hakan", "Işık", "Makü", "Antalya"];
  var seenn = Set<String>();
  List<String> uniquelists = [];

  late String _selectedtruck;

  @override
  void initState() {
    super.initState();
    // Initialize the list of unique countries
    uniquelist = countries.where((country) => seen.add(country)).toList();

    _selectedCountry = uniquelist[0];

    uniquelists = trucks.where((truck) => seenn.add(truck)).toList();

    _selectedtruck= uniquelists[0];
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

              child:DropdownButton(
                icon: Icon(Icons.arrow_drop_down_circle,color: HexColor("#41D6B3"),),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: HexColor("#343B55"),fontSize:20,
                      letterSpacing: .5,fontWeight: FontWeight.w700),
                ),

                value: _selectedCountry,
                items: uniquelist.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (selectedCountry) {
                  setState(() {
                    _selectedCountry = selectedCountry!;
                  });
                },
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

              child:DropdownButton(
                icon: Icon(Icons.arrow_drop_down_circle,color: HexColor("#41D6B3"),),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: HexColor("#343B55"),fontSize:20,
                      letterSpacing: .5,fontWeight: FontWeight.w700),
                ),

                value: _selectedtruck,
                items: uniquelists.map((truck) {
                  return DropdownMenuItem(
                    value: truck,
                    child: Text(truck),
                  );
                }).toList(),
                onChanged: (selectedtruck) {
                  setState(() {
                    _selectedtruck = selectedtruck!;
                  });
                },
              ),
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
                  hintText: "Çıkış Birimi",
                  border: InputBorder.none,



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

              child: TextField(


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
                  hintText: "Varış Birimi",
                  border: InputBorder.none,



                ),


              ),
            ),


            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Giriş Tarhi ve Saatı",
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
                  hintText: "Giriş Tarhi ve Saatı",
                  border: InputBorder.none,



                ),


              ),
            ),



            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Çıkış Tarhi ve Saatı",
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
                  hintText: "Çıkış Tarhi ve Saatı",
                  border: InputBorder.none,



                ),


              ),
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
                  hintText: "Konteyner Numarası",
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

                    "Güncelle",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white,fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),

                  ), onPressed: (){


              }),
            ),



          ],
        ),
      ),
      ),
    );





  }

}
