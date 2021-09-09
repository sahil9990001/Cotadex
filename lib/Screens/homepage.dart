import 'dart:convert';
import 'package:cato/Modals/api2.dart';
import 'package:cato/Modals/cota_APi.dart';
import 'package:cato/Screens/Coin%20card.dart';
import 'package:cato/widgets/Painter.dart';
import 'package:cato/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  late List<Welcome> listData;
  HomePage({required this.listData});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loading = false;
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List filteredNames = []; // names filtered by search text
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget _text = new Text(
    "COIN ANALYTICS",
    textAlign: TextAlign.center,
    style: GoogleFonts.lato(
      fontStyle: FontStyle.normal,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = widget.listData;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._text = Container(
          // color: Colors.amber,
          width: 200,
          height: 40,
          child: new TextField(
            style: TextStyle(color: Colors.white),
            controller: _filter,
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: new Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search...'),
          ),
        );
      } else {
        this._searchIcon = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this._text = new Text(
          "COIN ANALYTICS",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontStyle: FontStyle.normal,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        );
        filteredNames = widget.listData;
        _filter.clear();
      }
    });
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
    Size size = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MyPainter(),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / 15,
          title: Center(
            child: Text(
              "COIN TRACKER",
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                fontStyle: FontStyle.normal,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        drawer: NavDrawer(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          primary: false,
          physics:
              ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: size.height / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: size.height * (0.034)),
                        width: size.width * (4 / 6),
                        height: size.height / 9,
                        child: Row(children: <Widget>[
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5, left: 10),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "CATODEX",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 30),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Logo.png'),
                                      fit: BoxFit.cover)),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                //from here other widgets will be placed by ternary operator
                new Container(
                    height: size.height * 0.7,
                    width: size.width,
                    child: makeList(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final kInnerDecoration = BoxDecoration(
    color: Colors.transparent,
    gradient: LinearGradient(colors: [
      Color(0xCC4B3AB4),
      Color(0xB75444B8),
      Color(0x936D5FC2),
      Color(0x64958CD3),
      Color(0x2dCDC8EA),
      Color(0x00FFFFFF),
    ]),
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xDD4B3AB4),
      Color(0xC75444B8),
      Color(0xA36D5FC2),
      Color(0x74958CD3),
      Color(0x3DCDC8EA),
      Color(0x10FFFFFF),
    ]),
    border: Border.all(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(32),
  );
  Widget makeList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .tokenPair
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    } else {
      filteredNames = widget.listData;
    }
    return ListView.builder(
      itemCount: filteredNames.length + 1,
      itemBuilder: (context, index) {
        return index == 0
            ? new Container(
                height: 50.0,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12.0),
                child: Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _text,
                      new SizedBox(
                          width: MediaQuery.of(context).size.width / 3),
                      GestureDetector(onTap: _searchPressed, child: _searchIcon)
                    ],
                  ),
                ),
              )
            : buildList(context, index);
      },
    );
  }

  static Future<Data2> getVolumeData(marketAddress) async {
    Response response = await get(
        Uri.parse("https://api.dexlab.space/v1/volumes/$marketAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString);
      var json = Data2.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  Container buildList(BuildContext context, index) {
    final ndata = filteredNames[index - 1];
    // print(ndata);
    String marketAddress = ndata.marketAddress;
    return Container(
      color: Colors.transparent,
      child: new Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xDD4B3AB4),
                    Color(0xC75444B8),
                    Color(0xA36D5FC2),
                    Color(0x74958CD3),
                    Color(0x3DCDC8EA),
                    Color(0x10FFFFFF),
                  ]),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Coin(
                                websiteLink: ndata.wesbite,
                                twitter: ndata.twitter,
                                discord: ndata.discord,
                                telegram: ndata.telegram,
                                calculatingSupply: ndata.circulatingSupply,
                                tokenAddress: ndata.tokenAddress,
                                marketAddress: marketAddress,
                                tokenpair: ndata.tokenPair,
                                tokenLogo: ndata.tokenLogo,
                                tokenname: ndata.tokenName,
                                tokenDiscription: ndata.tokenDescription)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: new Container(
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        //color: Colors.transparent,
                        gradient: LinearGradient(colors: [
                          Color(0xCC4B3AB4),
                          Color(0xB75444B8),
                          Color(0x936D5FC2),
                          Color(0x64958CD3),
                          Color(0x2dCDC8EA),
                          Color(0x00FFFFFF),
                        ]),
                        //border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 5, left: 15),
                                child: Container(
                                    width: 60,
                                    height: 60,
                                    child: Image.network(ndata.tokenLogo))),
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 20),
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                    Text(
                                      ndata.tokenPair,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 30),
                                      child: Text(
                                        ndata.tokenName,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.lato(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 30),
                              child: Text(
                                '0.711',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ])),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
