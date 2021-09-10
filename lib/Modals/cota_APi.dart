import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.tokenName,
    required this.tokenPair,
    required this.tokenDescription,
    required this.marketAddress,
    required this.tokenAddress,
    required this.tokenLogo,
    required this.wesbite,
    required this.twitter,
    required this.discord,
    required this.telegram,
    required this.circulatingSupply,
    required this.tradenow,
  });

  String tokenName;
  String tokenPair;
  String tokenDescription;
  String marketAddress;
  String tokenAddress;
  String tokenLogo;
  String wesbite;
  String twitter;
  String discord;
  String telegram;
  String circulatingSupply;
  String tradenow;

  factory Welcome.fromJson(Map<dynamic, dynamic> json) => Welcome(
      tokenName: json["token_name"],
      tokenPair: json["token_pair"],
      tokenDescription: json["token_description"] == null
          ? 'null'
          : json["token_description"],
      marketAddress: json["market_address"],
      tokenAddress: json["token_address"],
      tokenLogo: json["token_logo"],
      wesbite: json["wesbite"],
      twitter: json["twitter"],
      discord: json["discord"],
      telegram: json["telegram"],
      circulatingSupply: json["circulating_supply"],
      tradenow: json["tradenow"]);

  Map<String, dynamic> toJson() => {
        "token_name": tokenName,
        "token_pair": tokenPair,
        "token_description": tokenDescription == null ? null : tokenDescription,
        "market_address": marketAddress,
        "token_address": tokenAddress,
        "token_logo": tokenLogo,
        "wesbite": wesbite,
        "twitter": twitter,
        "discord": discord,
        "telegram": telegram,
        "circulating_supply": circulatingSupply,
        "tradenow": tradenow
      };
}
