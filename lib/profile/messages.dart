import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';


class sendus extends StatelessWidget {
  sendus(this.name,);

  late String name;


  @override
  Widget build(BuildContext context) {





    return  Scaffold(

      body:Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HexColor("#F6F6F6"),

          borderRadius: BorderRadius.circular(20),



        ),
        child:Column(
          children: [


            SizedBox(height: 50,),
            Row(
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F9FAFB"),

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  }, icon: Icon(CupertinoIcons.arrow_left,
                    color:HexColor("#002851"),size: 30,)

                  ),
                ),

                Text(
                  "Mesaj Göndermek",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#002851"),fontSize: 23,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),


              ],
            ),
            SizedBox(height: 20,),


            Container(
              width: 50,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 15),

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: HexColor("#41D6B3"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],



              ),

              child: Text(
                name[0],
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: Colors.white,fontSize: 40,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Adınız",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              color: HexColor("#F0F3FD"),
              child: TextField(
                onChanged: (value){
                  name = value;
                },
                style:GoogleFonts.rubik(
                  textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 17,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 15,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "Adınız",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#E2E3E7"), // set border color here
                      width: 1.0, // set border width here
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here
                  ),


                ),
              ),
            ),


            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Başlık",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              color: HexColor("#F0F3FD"),
              child: TextField(
                onChanged: (value){

                },
                style:GoogleFonts.rubik(
                  textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 17,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 15,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "Başlık",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#E2E3E7"), // set border color here
                      width: 1.0, // set border width here
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here
                  ),


                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Mesajınız",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              color: HexColor("#F0F3FD"),
              child: TextField(
                onChanged: (value){

                },
                style:GoogleFonts.rubik(
                  textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 17,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 15,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "Measjınızı Yazın",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#E2E3E7"), // set border color here
                      width: 1.0, // set border width here
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here
                  ),


                ),
              ),
            ),

            SizedBox(height: 20,),
            GestureDetector(

              child: Container(

                  padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: HexColor("#ECEFFE"),

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Gönder",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(color: HexColor("#41D6B3"),fontSize:22,
                              letterSpacing: .5,fontWeight: FontWeight.w500),
                        ),
                      ),

                      Icon(CupertinoIcons.arrowtriangle_right_fill,
                        color:HexColor("#41D6B3"),size: 36,)





                    ],
                  )
              ),
            ),


          ],
        ),
      ),
    );



  }

}

