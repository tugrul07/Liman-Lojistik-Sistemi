import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart';

class faqs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body:Container(
        child: SingleChildScrollView(
          child:Container(

        decoration: BoxDecoration(
          color: HexColor("#F6F6F6"),

          borderRadius: BorderRadius.circular(20),



        ),
        child:Column(
          children: [


            SizedBox(height: 60,),
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
                    color:HexColor("#042a14"),size: 30,)

                  ),
                ),

                Text(
                  "FAQs ",
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
                "A",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: Colors.white,fontSize: 40,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 20,),
            faqstheme(
                "Nasıl araç ekleyebilirim?",
                "C: Giriş yaptıktan sonra araçlar sayfasına gidin. Burada yeni bir araç eklemek için 'Araç Ekle' seçeneğini seçin. Birden fazla araç ekleyebilirsiniz."
            ),
            SizedBox(height: 20,),
            faqstheme(
                "Araçları nasıl silebilirim?",
                "C: Bir aracı silmek istediğinizde, araçlar sayfasından ilgili aracı seçin. Sonra 'Araç Sil' seçeneğini seçerek aracı sistemden kaldırabilirsiniz."
            ),
            SizedBox(height: 20,),
            faqstheme(
                "Yeni iş nasıl eklerim?",
                "C: Yeni bir iş eklemek için ana paneldeki 'İş Ekle' seçeneğini kullanın. Gerekli bilgileri doldurduktan sonra işinizi kaydedebilirsiniz."
            ),


            SizedBox(height: 20,),
            faqstheme(
                "Yapılan işleri nasıl görüntüleyebilirim?",
                "C: Yapılan işleri görmek için ana paneldeki 'Yapılan İşler' bölümünü ziyaret edin. Burada geçmiş işlerinizi ve iş detaylarınızı bulabilirsiniz."
            ),




          ],
        ),
      ),
    ),
    ),
    );



  }

}

class faqstheme extends StatelessWidget {

  faqstheme(this.qu,this.ans,);


  late String qu;
  late String ans;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor:HexColor("#ECEFFE") ,
      iconColor: HexColor("#ECEFFE"),

      title:  Text(
        qu,
        style: GoogleFonts.rubik(
          textStyle: TextStyle(color: HexColor("#002851"),fontSize:17,
              letterSpacing: .5,fontWeight: FontWeight.w500),
        ),
      ), //header title
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child:
          Text( ans,

            style: GoogleFonts.rubik(
              textStyle: TextStyle(color: HexColor("#8194AC"),fontSize:14,
                  letterSpacing: .5,fontWeight: FontWeight.w500),
            ),
          ),),


      ],
    );
  }
}