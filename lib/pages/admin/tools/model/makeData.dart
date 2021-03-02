// To parse this JSON data, do
//
//     final makedata = makedataFromJson(jsonString);

import 'dart:convert';

List<Makedata> makedataFromJson(String str) => List<Makedata>.from(json.decode(str).map((x) => Makedata.fromJson(x)));

String makedataToJson(List<Makedata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Makedata {
    Makedata({
        this.name,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.loans,
        this.deposit,
        this.barang,
    });

    String name;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> loans;
    List<dynamic> deposit;
    List<dynamic> barang;

    factory Makedata.fromJson(Map<String, dynamic> json) => Makedata(
        name: json["name"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loans: List<dynamic>.from(json["loans"].map((x) => x)),
        deposit: List<dynamic>.from(json["deposit"].map((x) => x)),
        barang: List<dynamic>.from(json["barang"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loans": List<dynamic>.from(loans.map((x) => x)),
        "deposit": List<dynamic>.from(deposit.map((x) => x)),
        "barang": List<dynamic>.from(barang.map((x) => x)),
    };
}
