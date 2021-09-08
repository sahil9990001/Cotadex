// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HolderApi welcomeFromJson(String str) => HolderApi.fromJson(json.decode(str));

String welcomeToJson(HolderApi data) => json.encode(data.toJson());

class HolderApi {
  HolderApi({
    required this.succcess,
    required this.data,
  });

  bool succcess;
  Data1 data;

  factory HolderApi.fromJson(Map<String, dynamic> json) => HolderApi(
        succcess: json["succcess"],
        data: Data1.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "succcess": succcess,
        "data": data.toJson(),
      };
}

class Data1 {
  Data1({
    required this.symbol,
    required this.name,
    required this.icon,
    required this.website,
    required this.twitter,
    required this.tag,
    required this.decimals,
    required this.coingeckoId,
    required this.holder,
  });

  String symbol;
  String name;
  String icon;
  String website;
  String twitter;
  List<Tag> tag;
  int decimals;
  String coingeckoId;
  int holder;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        symbol: json["symbol"],
        name: json["name"],
        icon: json["icon"],
        website: json["website"],
        twitter: json["twitter"],
        tag: List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
        decimals: json["decimals"],
        coingeckoId: json["coingeckoId"],
        holder: json["holder"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "icon": icon,
        "website": website,
        "twitter": twitter,
        "tag": List<dynamic>.from(tag.map((x) => x.toJson())),
        "decimals": decimals,
        "coingeckoId": coingeckoId,
        "holder": holder,
      };
}

class Tag {
  Tag({
    required this.name,
    // required this.description,
  });

  String name;
  // String description;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        // description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        // "description": description,
      };
}
