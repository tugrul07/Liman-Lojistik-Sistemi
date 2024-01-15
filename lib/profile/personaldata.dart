import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';


class personaldata extends StatelessWidget {

  personaldata(this.name,this.email,this.role,);

  late String name;
  late String email;
  late String role;
  late String password;
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


            SizedBox(height: 20,),
           Row(
             children: [

               Container(
                 decoration: BoxDecoration(


                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: IconButton(onPressed: () {
                   FocusScope.of(context).unfocus();
                   Navigator.pop(context);
                 }, icon: Icon(CupertinoIcons.arrow_left,
                   color:HexColor("#042a14"),size: 30,)

                 ),
               ),

               Text(
                 "Kişisel veri",
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
            SizedBox(height: 10,),
            Container(

              alignment: Alignment.center,
              child: Text(
                email,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Adınız ",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(


              color: HexColor("#F0F3FD"),
             child: Row(

                children: [
                  Container(
                    width: 50,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 15),

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: HexColor("#41D6B3"),
                      borderRadius:BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],



                    ),

                    child:Icon(CupertinoIcons.profile_circled,size: 40,color: Colors.white,),
                  ),

                  Text(
                   name,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 22,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),
                  )

                ],
              )
            ),


        SizedBox(height: 20,),


            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "E-Postanız ",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(


                color: HexColor("#F0F3FD"),
                child: Row(

                  children: [
                    Container(
                      width: 50,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 15),

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: HexColor("#41D6B3"),
                        borderRadius:BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],



                      ),

                      child:Icon(CupertinoIcons.mail,size: 40,color: Colors.white,),
                    ),

                    Text(
                      email,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 22,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    )

                  ],
                )
            ),


            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Rolünüz ",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(


                color: HexColor("#F0F3FD"),
                child: Row(

                  children: [
                    Container(
                      width: 50,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 15),

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: HexColor("#41D6B3"),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],



                      ),

                      child:Icon(CupertinoIcons.briefcase, size: 40,color: Colors.white,),
                    ),

                    Text(
                      role,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 22,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    )

                  ],
                )
            ),


            SizedBox(height: 20,),





          ],
        ),
      ),
       );



  }

}

