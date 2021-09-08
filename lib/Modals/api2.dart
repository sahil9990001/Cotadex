// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Volume welcomeFromJson(String str) => Volume.fromJson(json.decode(str));

String welcomeToJson(Volume data) => json.encode(data.toJson());

class Volume {
  Volume({
    required this.success,
    required this.data,
  });

  bool success;
  Data2 data;

  factory Volume.fromJson(Map<String, dynamic> json) => Volume(
        success: json["success"],
        data: Data2.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data2 {
  Data2({
    required this.address,
    required this.programId,
    required this.price,
    required this.summary,
    required this.last24HOrder,
  });

  String address;
  String programId;
  double price;
  Summary summary;
  Last24HOrder last24HOrder;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        address: json["address"],
        programId: json["programId"],
        price: json["price"].toDouble(),
        summary: Summary.fromJson(json["summary"]),
        last24HOrder: Last24HOrder.fromJson(json["last24hOrder"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "programId": programId,
        "price": price,
        "summary": summary.toJson(),
        "last24hOrder": last24HOrder.toJson(),
      };
}

class Last24HOrder {
  Last24HOrder({
    required this.exist,
    required this.time,
    required this.price,
    required this.percent,
  });

  bool exist;
  DateTime time;
  String price;
  String percent;

  factory Last24HOrder.fromJson(Map<String, dynamic> json) => Last24HOrder(
        exist: json["exist"],
        time: DateTime.parse(json["time"]),
        price: json["price"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "exist": exist,
        "time": time.toIso8601String(),
        "price": price,
        "percent": percent,
      };
}

class Summary {
  Summary({
    required this.totalVolume,
    required this.sellVolume,
    required this.buyVolume,
    required this.highPrice,
    required this.lowPrice,
  });

  double totalVolume;
  double sellVolume;
  double buyVolume;
  double highPrice;
  double lowPrice;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalVolume: json["totalVolume"].toDouble(),
        sellVolume: json["sellVolume"].toDouble(),
        buyVolume: json["buyVolume"].toDouble(),
        highPrice: json["highPrice"].toDouble(),
        lowPrice: json["lowPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "totalVolume": totalVolume,
        "sellVolume": sellVolume,
        "buyVolume": buyVolume,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
      };
}
