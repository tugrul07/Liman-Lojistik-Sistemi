import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart';

class aboutus extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  return  Scaffold(

      body:Container(
        child: Column(

        children: [
          SizedBox(height: 60,width: 10,),
          Container(
            margin: EdgeInsets.only(left: 10),
            child:Row(

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







              ],
            ),
          ),
          Container(

            child:  Text(
              "Lojistik Uygulamamız",

              style: GoogleFonts.rubik(
                textStyle: TextStyle(color: HexColor("#002851"),fontSize:30,
                    letterSpacing: .5,fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Image.network("https://img.freepik.com/free-vector/team-programmers-working-program-code-with-laptops-teamwork-male-female-professional-testers-coders-flat-vector-illustration-software-development-programming-lesson-concept_74855-22051.jpg"),
          ),

          Container(
            margin: EdgeInsets.all(20),
            child:  Text(
              "Biz, lojistik sektöründe verimliliği ve kullanıcı deneyimini ön planda tutan bir ekibiz."
                  " Lojistik Uygulamamız, işlerinizi kolaylaştırmak ve yönetim süreçlerinizi daha etkili hale "
                  "getirmek için tasarlanmış bir çözümdür."

                "Amacımız, lojistik süreçlerinizi daha verimli hale getirerek işlerinizi kolaylaştırmaktır. "
                  "Kullanıcı odaklı yaklaşımımızla, sürekli gelişen ve yenilenen uygulamamızı sizin ihtiyaçlarınıza "
                  "uygun şekilde şekillendiriyoruz.",
              style: GoogleFonts.rubik(
                textStyle: TextStyle(color: HexColor("#002851"),fontSize:15,
                    letterSpacing: .5,fontWeight: FontWeight.w500),
              ),
            ),
          )
        ]
    ),
   ),
  );



  }

}

