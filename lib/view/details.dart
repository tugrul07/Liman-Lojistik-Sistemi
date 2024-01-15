import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staj_project/controllers/newJob.dart';

import '../controllers/updateKonteyner.dart';
import 'package:flutter/services.dart';




class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  _detailsstate createState() => _detailsstate();
}

class _detailsstate extends State<details> {


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
                IconButton(onPressed: (){Navigator.pop(context);},
                    icon: Icon(CupertinoIcons.arrow_left_to_line_alt,size:30,color: HexColor("#4C4959"),)),
                Text(
                  "İş Bilgileri",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: HexColor("#4B5256"),fontSize: 24,
                        letterSpacing: .2,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40,),




             Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:  HexColor("#CEEBF4"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                  bottomLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),




              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    child: Text(
                      "34 ACV 350",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: HexColor("#042a14"),fontSize: 24,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  Image.network("https://cdn-icons-png.flaticon.com/512/2888/2888724.png",width: 100,height: 100,)



                ],
              ) ,
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
                            "caxu 192-122",
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
                            "07.07.2023",
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

                      Icon(CupertinoIcons.money_dollar_circle,size: 40,),

                      Text(
                        "20 ₺",
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
                    color: HexColor("#ffc9c9"),
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

                      Icon(CupertinoIcons.doc_text_fill,size: 40,),

                      Text(
                        "Kesilmedi",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => updateKonteyner()),
                  );
                }),
              ),




          ],
        ),
      ),
    );





  }

}
