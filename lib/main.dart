import 'dart:async';
import 'package:cato/Screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: HexColor("#22136B"),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:2,bottom: 10,left: 10),
                        child: Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
                          height: MediaQuery.of(context).size.width/2.5,
                          width:MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Logo.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.width/6,
                          child:Text(" CATO",style: GoogleFonts.lato(
                            fontStyle: FontStyle.normal,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),),),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width/6,
                        child:Text(" Coin Tracking App ",style: GoogleFonts.lato(
                          fontStyle: FontStyle.normal,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),),),
                    ],
                  ),
                ])
        ),
      ),
    );}
}

