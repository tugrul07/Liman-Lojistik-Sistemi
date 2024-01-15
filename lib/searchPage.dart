import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart';
import 'view/details.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  searchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class searchPage extends StatefulWidget {


  @override
  _searchPagestate createState() => _searchPagestate();
}

class _searchPagestate extends State<searchPage> {



  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(50, (i) => "2$i EG$i X$i ");
  var items = <String>[];

  @override
  void initState() {
    items = duplicateItems;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (items.isEmpty) {
        items.add("Yazdığınız araç \nnumarası bulunmamış.");
      }
    });
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


            Text(
              "Arama Sayfası",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: HexColor("#010e07"),fontSize: 24,
                    letterSpacing: .5,fontWeight: FontWeight.w700),
              ),
            ),





            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Araç plakası ",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: HexColor("#010e07"),fontSize: 16,
                      letterSpacing: .2,fontWeight: FontWeight.w600),
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
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,


                style:GoogleFonts.montserrat(
                  textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(color:HexColor("#343B55"),fontSize: 18,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "Ara...",
                  border: InputBorder.none,



                ),


              ),
            ),
            SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => details()),
                      );



                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(children: [
                          Container(

                              decoration: BoxDecoration(
                                color: HexColor("#F6F7FE"),


                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Image.network("https://img.icons8.com/color/48/container-truck.png",height: 50,width: 50,)

                          ),
                          SizedBox(width: 14,),
                          Text(
                            "${items[index]}",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(color: HexColor("#010e07"),fontSize:17,
                                  letterSpacing: .5,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],),
                        Container(
                          padding: EdgeInsets.all(3),

                          decoration: BoxDecoration(
                            color: HexColor("#41D6B3"),


                            borderRadius: BorderRadius.circular(20),
                          ),

                          child:Icon(Icons.arrow_forward_ios,color:Colors.white,size: 20,),
                        ),



                      ],
                    ),
                  );
                },
              ),
            ),



          ],
        ),
      ),
    );





  }

}
