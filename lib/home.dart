import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

import 'view/jobs.dart';
import 'view/trucks.dart';
import 'view/dashboard.dart';

import 'profile/personaldata.dart';
import 'profile/aboutus.dart';
import 'profile/faqs.dart';
import 'profile/messages.dart';
import 'searchPage.dart';


import 'controllers/notifi_model.dart';
import 'controllers/newJob.dart';


class homeMain extends StatefulWidget {



  @override
  _CupertinoBottomNavBarState createState() => _CupertinoBottomNavBarState();
}

//-------------VERİLERİ DEPOLAMAK ,ALMAK VE KULLANMAK İÇİN DEĞİŞKEN OLUSTURMA--------------

final datacount = GetStorage();
 String id = '';
 String name = '';
 String email = "";
 late String role ;

class _CupertinoBottomNavBarState extends State<homeMain> {
  int _selectedIndex = 0;
  static  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);


  String? token;

//--------------VERİLERİ ÇEKMEK--------------

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  //--------------API DEN ALINAN VERİLERİ DEPOLAMS VE ÇEKME İŞLEMLERİ -------------

  List<Map<String, dynamic>> dataArray = []; // This is the array to store the fetched data

  // Function to fetch data from the API
  Future<void> fetchData() async {
    if (datacount.read('token') != null) {
      setState(() {
        token = datacount.read('token');
      });
      print('Token before decoding: $token');
    }
    final url = 'http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/users/profile';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // If the API call is successful, parse the JSON data and store it in the array
        final jsonData = json.decode(response.body);
        setState(() {
          dataArray.add(jsonData);
          id = dataArray[0]['id'];
          name = dataArray[0]['name'];
          email = dataArray[0]['email'];
          role = dataArray[0]['role'];
        });
      } else {
        // Handle error if the API call is not successful
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle any other errors that might occur during the API call
      print('Error fetching data: $e');
    }
  }


  static  List<Widget> _widgetOptions = <Widget>[

    apps(),

    role =="ADMIN" ? dashboard() : warning( "Sayfaya erişim izniniz yok",Icon(
      Icons.warning_rounded ,
      color:Colors.redAccent ,
      size: 30,
    ),) ,
    role =="ADMIN" ? searchPage() : warning( "Sayfaya erişim izniniz yok",Icon(
      Icons.warning_rounded ,
      color:Colors.redAccent ,
      size: 30,
    ),),

    profile(),

  ];


// -----------------SAYFA GÖRÜNÜMLERİ-------------------------


  Widget build(BuildContext context) {
    print("the token is:" );
print(role);




 return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: HexColor("#13a474"),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Ana Sayfa',
                ),
                GButton(
                  icon: Icons.account_tree_outlined,
                  text: 'Gösterge Paneli',
                ),

                GButton(
                  icon: Icons.search,
                  text: 'Arama',
                ),

                GButton(
                  icon: Icons.settings,
                  text: 'Profil',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


//------------------UYGULAMA ANASAYFA WIDGETI------------------

class profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

//---------PROFİLE KISMI(KİŞİSEL VERİ, FAQS,MESAJ YAZ,HAKKIMIZDA VE ÇIKIŞ YAP)--------------

    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        children: [
          SizedBox(height: 40,),

          Container(
            child: Row(
              children: [
                Container(
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
                        color: Colors.blue.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],



                  ),

                  child: Text(
                    email[0],
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: Colors.white,fontSize: 40,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tuğrul",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#002851"),fontSize: 23,
                            letterSpacing: .5,fontWeight: FontWeight.w600),
                      ),
                    ),

                    Text(
                      "tugrulsoysal1@gmail.com",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#637C94"),fontSize:17,
                            letterSpacing: .5,fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          SizedBox(height: 20,),

          GestureDetector(
            onTap: () {



              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => personaldata("tugrul soysal", "tugrul@gmail.com", "admin")),
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
                      child:  Icon(CupertinoIcons.person_solid,
                        color:HexColor("#41D6B3"),size: 36,)

                  ),
                  SizedBox(width: 9,),
                  Text(
                    "Kişisel veri",
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: HexColor("#042a14"),fontSize:17,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
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
          ),

          SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => faqs()),
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
                      child: Icon(Icons.feedback,
                        color:HexColor("#41D6B3"),size: 36,)

                  ),
                  SizedBox(width: 9,),
                  Text(
                    "FAQs",
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: HexColor("#042a14"),fontSize:17,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
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
          ),

          SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => sendus("ali hakan")),
              );

            },
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(children: [
                  Container(
                      decoration: BoxDecoration(
                        color: HexColor("#F6F7FE"),

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  Icon(CupertinoIcons.ellipses_bubble_fill,
                        color:HexColor("#41D6B3"),size: 36,)


                  ),
                  SizedBox(width: 9,),
                  Text(
                    "Mesaj Yaz",
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(color: HexColor("#042a14"),fontSize:17,
                          letterSpacing: .5,fontWeight: FontWeight.w500),
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

          ),




          SizedBox(height: 20,),

          GestureDetector(

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => aboutus()),
                );

              },

              child: Container(
                width: 400,
                height: 50,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(children: [
                      Container(
                          decoration: BoxDecoration(
                            color: HexColor("#F6F7FE"),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Icon(CupertinoIcons.ellipsis_circle_fill,
                            color:HexColor("#41D6B3"),size: 36,)

                      ),
                      SizedBox(width: 9,),
                      Text(
                        "Hakkımızda",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(color: HexColor("#042a14"),fontSize:17,
                              letterSpacing: .5,fontWeight: FontWeight.w500),
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
                ),)

          ),

          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              datacount.remove('token');
              Navigator.pop(context);


            },
            child: Container(

                padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: HexColor("#feecec"),

                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Çıkış Yap",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: HexColor("#d7425d"),fontSize:22,
                            letterSpacing: .5,fontWeight: FontWeight.w500),
                      ),
                    ),

                    Icon(CupertinoIcons.arrow_right_square_fill,
                      color:HexColor("#d7425d"),size: 36,)





                  ],
                )
            ),
          ),

        ],
      ),
    );




  }

}


// -----------------ANASAYFA YAPISI,DÜZENİ, BİÇİMLERİ--------------
//HOGELDİNİZ,LOJİSTİK UYGULAMANIZ , ARAÇLAR, İŞLERİM, YENİ İŞ

class apps extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return Container(
       margin: EdgeInsets.all(30),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,


        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Hoş Geldiniz ",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: HexColor("#1C1A1A"),fontSize: 24,
                    letterSpacing: .5,fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 20,),




          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Lojistik uygulamanız",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: HexColor("#1C1A1A"),fontSize: 24,
                    letterSpacing: .5,fontWeight: FontWeight.w500),
              ),
            ),
          ),


            SizedBox(height: 20,),




         GestureDetector(
           onTap: (){
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => trucks()),
             );


           },
           child:  Container(
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
                     "Araçlar",
                     style: GoogleFonts.alef(
                       textStyle: TextStyle(color: HexColor("#4B5256"),fontSize: 24,
                           letterSpacing: .5,fontWeight: FontWeight.w600),
                     ),
                   ),
                 ),

                 Image.network("https://cdn-icons-png.flaticon.com/512/2888/2888724.png",width: 100,height: 100,)



               ],
             ) ,
           ),
         ),



          SizedBox(height: 20,),

          GestureDetector(
          onTap: ()   {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => jobs()),
            );



          },
          child:Container(
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
                    "İşlerim",
                    style: GoogleFonts.alef(
                      textStyle: TextStyle(color: HexColor("#4B5256"),fontSize: 24,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                Image.network("https://img.icons8.com/fluency/96/new-job.png",width: 90,height: 90,)



              ],
            ) ,
          ),
      ),


          SizedBox(height: 20,),



          GestureDetector(
            onTap: ()   {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addJob("")),
              );



            },
         child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:  HexColor("#47E0C1"),
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
                    "Yeni İş",
                    style: GoogleFonts.alef(
                      textStyle: TextStyle(color: Colors.white,fontSize: 24,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                Image.network("https://img.icons8.com/external-outline-stroke-bomsymbols-/256/external-container-logistics-outline-stroke-bomsymbols-.png",width: 100,height: 100,color: Colors.white,)



              ],
            ) ,
          ),
    ),



        ],
      ),
    );





  }

}

