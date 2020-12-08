// To parse this JSON data, do
//
//     final bill = billFromMap(jsonString);

import 'dart:convert';

class Bill {
    Bill({
        this.bid,
        this.pharmacy,
        this.total,
    });

    int bid;
    String pharmacy;
    int total;

    factory Bill.fromJson(String str) => Bill.fromMap(json.decode(str)[0]);

    String toJson() => json.encode(toMap());

    factory Bill.fromMap(Map<String, dynamic> json) => Bill(
        bid: json["bid"],
        pharmacy: json["pharmacy"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "bid": bid,
        "pharmacy": pharmacy,
        "total": total,
    };
}
