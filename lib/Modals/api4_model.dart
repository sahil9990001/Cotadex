// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Api4 welcomeFromJson(String str) => Api4.fromJson(json.decode(str));

String welcomeToJson(Api4 data) => json.encode(data.toJson());

class Api4 {
  Api4({
    required this.succcess,
    required this.data,
  });

  bool succcess;
  Data4 data;

  factory Api4.fromJson(Map<String, dynamic> json) => Api4(
        succcess: json["succcess"],
        data: Data4.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "succcess": succcess,
        "data": data.toJson(),
      };
}

class Data4 {
  Data4({
    required this.lamports,
    required this.ownerProgram,
    required this.type,
    required this.rentEpoch,
    required this.account,
    required this.tokenInfo,
  });

  int lamports;
  String ownerProgram;
  String type;
  int rentEpoch;
  String account;
  TokenInfo tokenInfo;

  factory Data4.fromJson(Map<String, dynamic> json) => Data4(
        lamports: json["lamports"],
        ownerProgram: json["ownerProgram"],
        type: json["type"],
        rentEpoch: json["rentEpoch"],
        account: json["account"],
        tokenInfo: TokenInfo.fromJson(json["tokenInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "lamports": lamports,
        "ownerProgram": ownerProgram,
        "type": type,
        "rentEpoch": rentEpoch,
        "account": account,
        "tokenInfo": tokenInfo.toJson(),
      };
}

class TokenInfo {
  TokenInfo({
    required this.name,
    required this.symbol,
    required this.decimals,
    // required this.tokenAuthority,
    required this.supply,
    required this.type,
  });

  String name;
  String symbol;
  int decimals;
  // String tokenAuthority;
  String supply;
  String type;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        name: json["name"],
        symbol: json["symbol"],
        decimals: json["decimals"],
        // tokenAuthority: json["tokenAuthority"],
        supply: json["supply"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "decimals": decimals,
        // "tokenAuthority": tokenAuthority,
        "supply": supply,
        "type": type,
      };
}
