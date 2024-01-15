//KULLANILACAK PAKETLERİN DAHİL EDİLMESİ
import 'package:flutter/material.dart'; //Flutter framework'ünü kullanabilmek için gerekli
import 'package:flutter/cupertino.dart';//(IOS OPTİMİZASYONU İÇİN)Cupertino stilindeki widget'ları kullanabilmek için
import 'package:google_fonts/google_fonts.dart';//PROJEMİZDE İSTEDİĞİMİZ YAZI FONTLARINI KULLANMAK İÇİN
import 'package:hexcolor/hexcolor.dart';//Renkleri hexadecimal formatla tanımlamak ve kullanmak için
import 'package:flutter/services.dart';//Flutter ve Dart özelliklerine erişim sağlamak için
import 'dart:convert'; // JSON kodlama ve çözme işlemleri için
import 'package:http/http.dart' as http;//HTTP istekleri göndermek ve almak için
import 'package:get/get.dart';//Flutter için geliştirilmiş bir state management (durum yönetimi) ve navigasyon yönetimi framework'ünü kullanmak için
import 'package:get_storage/get_storage.dart';// Basit ve hızlı bir şekilde verileri depolamak ve almak için

import 'siginup.dart';// Giriş yapmadıysa kullanıcıyı yönlendirmek amacıyla SignUp ekranına yönlendirmek için
import 'home.dart';// Uygulamanın ana ekranını içeren dosyalar
import 'controllers/notifi_model.dart';//Bildirimlerle ilgili işlemleri gerçekleştirmek için

void main() async {
  await GetStorage.init();   //get storage initialization
  runApp(MyApp());
}

class MyApp extends StatelessWidget {




  @override
  Widget build(BuildContext context) {




    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String email;
  late String password;


  final datacount = GetStorage();   // instance of getStorage class

  //-----------API'YA İSTEK ATMA VE LOGİN İŞLEMİ BAŞARILI MI?------------------

  Future<void> loginUser(String email, String password) async {
    final String apiUrl = 'http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/auth/signin';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        String token = json.decode(response.body)['access_token'];
        datacount.write("token", token);// Await the saving of the token

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homeMain()),
        );
        showCustomModal(context, 'Başarıyla giriş yaptınız', false);

      } else {
        print( 'Login failed. Error: ${response.statusCode}');
        showCustomModal(context, 'Şifre veya E-posta yanlıştır.', true);
      }
    } catch (e) {
      print( 'Error occurred during login: $e');
      showCustomModal(context, 'Girişte hata oldu: $e', true);
    }
  }

  @override
  void initState() {
    super.initState();
    controlToken();
  }

//-----------Token kontrolü ve sayfa başlatıldığında otomatik olarak yapılması gereken işlemler----------------

  Future<void> controlToken() async {
    var token = datacount.read("token");
    final url = 'http://ec2-52-59-231-57.eu-central-1.compute.amazonaws.com:3333/users/profile';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // If the API call is successful, parse the JSON data and store it in the array
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => homeMain()),
          );
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


//----------SAYFANIN GÖRÜNÜMÜ--------------

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




            Text(
              "Giriş Sayfası",
              style: GoogleFonts.rubik(
                textStyle: TextStyle(color: HexColor("#010e07"),fontSize: 23,
                    letterSpacing: .5,fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 20,),


            Image.network("https://cdn-icons-png.flaticon.com/512/2888/2888724.png",width: 100,height: 100,),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "E-Postanız ",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#010e07"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              color: HexColor("#F0F3FD"),
              child: TextField(
                style:GoogleFonts.rubik(
                  textStyle: TextStyle(color:HexColor("#042a14"),fontSize: 17,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color:HexColor("#27496D"),fontSize: 15,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "E-postanızı Giriniz",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#010e07"), // set border color here
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
                "Şifreniz ",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(color: HexColor("#010e07"),fontSize: 16,
                      letterSpacing: .5,fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Container(
              color: HexColor("#F0F3FD"),
              child: TextField(
                obscureText:true,

                style:GoogleFonts.rubik(
                  textStyle: TextStyle(color:HexColor("#010e07"),fontSize: 17,
                      letterSpacing: .5,fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color:HexColor("#010e07"),fontSize: 15,
                        letterSpacing: .5,fontWeight: FontWeight.w500),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  hintText: "Şifrenizi Giriniz",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#010e07"), // set border color here
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

                    "Giriş Yap",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white,fontSize: 18,
                          letterSpacing: .5,fontWeight: FontWeight.w600),
                    ),

                  ), onPressed: ()async{

// ----------------DEFAULT E-POSTA VE ŞİFRE BELİRLEME----------------------

    if(email=="tugrul@gmail.com" && password=="12345"){
      await loginUser("osama@gmail.com","osama12345");

    }else{
      showCustomModal(context, 'Şifre veya E-posta yanılştır.', true);

    }


              }),
            ),




            SizedBox(height: 20,),


          ],
        ),
      ),
    );



  }

}


