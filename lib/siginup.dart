import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart';
import 'main.dart';


class siginup extends StatelessWidget {
  late String email;
  late String password;
  late String name;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body:SingleChildScrollView(
        child:Container(
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
                      color: HexColor("#F9FAFB"),

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(onPressed: () {

                      Navigator.pop(context);
                    }, icon: Icon(CupertinoIcons.arrow_left,
                      color:HexColor("#002851"),size: 30,)

                    ),
                  ),

                  Text(
                    "Login As Company ",
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: HexColor("#002851"),fontSize: 23,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20,),


              Container(

                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 15),

                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
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

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "LojistikOS",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(color: Colors.white,fontSize: 40,
                              letterSpacing: .5,fontWeight: FontWeight.w600),
                        ),
                      ),

                      Icon(Icons.local_shipping_sharp,size: 40,color: Colors.white,)
                    ],
                  )
              ),
              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Company Id ",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                color: HexColor("#F0F3FD"),
                child: TextField(
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
                    hintText: "Ex:Ux1300",
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
                  "Your Email ",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                color: HexColor("#F0F3FD"),
                child: TextField(
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
                    hintText: "Mailinizi giriniz:",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor("#E2E3E7"), // set border color here
                        width: 1.0, // set border width here
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here
                    ),


                  ),
                  onChanged: (value){
                    email = value;
                  },
                ),
              ),

              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Password ",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              Container(
                color: HexColor("#F0F3FD"),
                child: TextField(
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
                    hintText: "Şifrenizi giriniz",

                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor("#E2E3E7"), // set border color here
                        width: 1.0, // set border width here
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)), // set border radius here
                    ),


                  ),
                  onChanged: (value){
                    password = value;
                  },
                ),
              ),


              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()   {

                },
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
                          "Login As Company",
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(color: HexColor("#617AF1"),fontSize:22,
                                letterSpacing: .5,fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(onPressed: (){

                        },
                            icon: Icon(CupertinoIcons.arrow_right_square_fill,
                              color:HexColor("#617AF1"),size: 36,)),

                      ],
                    )
                ),
              ),


              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.center,
                child: Text(
                  "Or",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(color: HexColor("#4A6783"),fontSize: 16,
                        letterSpacing: .5,fontWeight: FontWeight.w600),
                  ),
                ),
              ),


              GestureDetector(
                onTap: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
                );
                },
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
                          "Login as person",
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(color: HexColor("#617AF1"),fontSize:22,
                                letterSpacing: .5,fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(CupertinoIcons.person_solid,
                          color:HexColor("#617AF1"),size: 36,)

                      ],
                    )
                ),
              ),


              SizedBox(height: 20,),


            ],
          ),
        ),
      ),

    );



  }

}

