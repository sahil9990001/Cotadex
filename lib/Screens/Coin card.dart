import 'dart:convert';
import 'dart:math';
import 'package:cato/Modals/api2.dart';
import 'package:cato/Modals/api3_modal.dart';
import 'package:cato/Modals/api4_model.dart';
import 'package:cato/Screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Coin extends StatefulWidget {
  String tradeNow;
  String websiteLink;
  String twitter;
  String discord;
  String telegram;
  String calculatingSupply;
  String marketAddress;
  String tokenAddress;
  String tokenDiscription;
  String tokenpair;
  String tokenname;
  String tokenLogo;
  Coin({
    required this.tradeNow,
    required this.discord,
    required this.telegram,
    required this.twitter,
    required this.websiteLink,
    required this.calculatingSupply,
    required this.marketAddress,
    required this.tokenAddress,
    required this.tokenDiscription,
    required this.tokenLogo,
    required this.tokenpair,
    required this.tokenname,
  });

  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  static Future<Data1> getTokenData1(tokenAddress) async {
    Response response = await get(
        Uri.parse("https://api.solscan.io/token/meta?token=$tokenAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data1.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  static Future<Data2> getVolumeData(marketAddress) async {
    Response response = await get(
        Uri.parse("https://api.dexlab.space/v1/volumes/$marketAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data2.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  static Future<Data4> getSupplyData(tokenAddress) async {
    Response response = await get(
        Uri.parse("https://api.solscan.io/account?address=$tokenAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data4.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  // bool _loaded = false;
// var img = Image.network(widget.tokenLogo);
// var placeholder = AssetImage(assetName)

  // @override
  // void initState() {
  //   super.initState();
  //   img.image.resolve(ImageConfiguration()).addListener((i, b) {
  //     if (mounted) {
  //       setState(() => _loaded = true);
  //     }
  //   });
  // }

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
                color: HexColor("#22136B"),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))), //new pluggin added
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, left: 10),
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text('COIN CARD\n',
                        style: GoogleFonts.lato(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w200))),
              ),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5, left: 30),
                        child: Container(
                            width: 100,
                            height: 100,
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/Logo.png',
                                image: widget.tokenLogo))),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Text(
                                widget.tokenpair == ''
                                    ? 'Unavailable'
                                    : widget.tokenpair,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                widget.tokenname,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                widget.tokenDiscription,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.lato(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                    )
                  ])),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRICE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Data2>(
                      future: getVolumeData(widget.marketAddress),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.price.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Data Unavailable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        }

                        // By default, show a loading spinner.
                        return Text(
                          'Loading.....',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VOLUME',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Data2>(
                      future: getVolumeData(widget.marketAddress),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.summary.totalVolume
                                .toInt()
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Data Unavailable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        }

                        // By default, show a loading spinner.
                        return Text(
                          'Loading.....',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MARKET CAP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Data2>(
                      future: getVolumeData(widget.marketAddress),
                      builder: (context, snapshot) {
                        // print(snapshot.data!.price);
                        // print(widget.calculatingSupply.toString());
                        if (snapshot.hasData) {
                          return Text(
                            widget.calculatingSupply == ""
                                ? 'Data Unavailable'
                                : ((snapshot.data!.price) *
                                        double.parse(widget.calculatingSupply
                                            .replaceAll(',', '')))
                                    .toInt()
                                    .toString()
                                    .replaceAllMapped(reg, mathFunc),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Data Unavailable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        }

                        // By default, show a loading spinner.
                        return Text(
                          'Loading.....',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'HOLDERS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Data1>(
                      future: getTokenData1(widget.tokenAddress),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.holder
                                .toInt()
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Data Unavailable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        }

                        // By default, show a loading spinner.
                        return Text(
                          'Loading.....',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUPPLY',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Data4>(
                      future: getSupplyData(widget.tokenAddress),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            (snapshot.data!.tokenInfo.supply
                                        .toString()
                                        .length ==
                                    1)
                                ? snapshot.data!.tokenInfo.supply.toString()
                                : (snapshot.data!.tokenInfo.supply
                                            .toString()
                                            .length >
                                        0)
                                    ? snapshot.data!.tokenInfo.supply
                                        .toString()
                                        .substring(
                                            0,
                                            snapshot.data!.tokenInfo.supply
                                                    .toString()
                                                    .length -
                                                snapshot
                                                    .data!.tokenInfo.decimals)
                                        .replaceAllMapped(reg, mathFunc)
                                    : snapshot.data!.tokenInfo.supply
                                        .toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Data Unavailable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          );
                        }

                        // By default, show a loading spinner.
                        return Text(
                          'Loading.....',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      launch(widget.websiteLink);
                      // print(widget.websiteLink);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Image.asset('assets/url.png')),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launch(widget.twitter);
                      // print(widget.websiteLink);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 20, top: 30, bottom: 0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: 55,
                          width: 55,
                          child: SvgPicture.asset(
                            'assets/twitter.svg',
                            height: 60,
                            width: 60,
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launch(widget.discord);
                      // print(widget.websiteLink);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 20, top: 30, bottom: 0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset('assets/discord.svg')),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launch(widget.telegram);
                      // print(widget.websiteLink);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 10, top: 30, bottom: 0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: 55,
                          width: 55,
                          child: SvgPicture.asset(
                            'assets/telegram.svg',
                            height: 60,
                            width: 60,
                          )),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0, top: 30, bottom: 0),
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [HexColor("#FFA910"), HexColor("#F962BB")]),
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      launch(widget.tradeNow);
                    },
                    child: Text(
                      'TRADE NOW',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
