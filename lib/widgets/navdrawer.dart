import 'package:cato/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ClipRRect(
             borderRadius: BorderRadius.only(
              topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
           child:Drawer(
             child:Container(
               color:Colors.grey,
               child:ListView(
                 padding: EdgeInsets.only(top: 50,left: 20),
                 children: <Widget>[
                   ListTile(
                     title: Text('OPTIONS',style: TextStyle(fontFamily: "Montserrat",
                         fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,
                         fontSize: 45,color: Colors.black87),),
                     contentPadding: EdgeInsets.only(left: 10,right: 20),
                     trailing: Icon(Icons.arrow_back_ios,
                       color: Colors.black87,),
                     onTap: () {
                       Navigator.of(context).pop();
                     },
                  ),
                     ListTile(
                      leading: Icon(Icons.home_rounded,color: Colors.black87),
                      title: Text('HOME',style: TextStyle(fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontSize: 25,color: Colors.black87,fontWeight: FontWeight.w400),),
                      onTap: () => { Navigator.of(context).pop() },
                    ),
                    ListTile(
                      leading: Icon(Icons.dynamic_feed_outlined,color: Colors.black87),
                      title: Text('FEEDBACK',style: TextStyle(fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontSize: 25,color: Colors.black87,fontWeight: FontWeight.w400),),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(Icons.question_answer_rounded,color: Colors.black87,),
                      title: Text('FAQ',style: TextStyle(fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontSize: 25,color: Colors.black87,fontWeight: FontWeight.w400),),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(Icons.person_pin,color: Colors.black87),
                      title: Text('SUPPORT',style: TextStyle(fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,
                          fontSize: 25,color: Colors.black87),),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(Icons.add_box_outlined,color: Colors.black87),
                      title: Text('ABOUT US',style: TextStyle(fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,
                        fontSize: 25,color: Colors.black87),),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
            ],
          ),
        )));
      }
}