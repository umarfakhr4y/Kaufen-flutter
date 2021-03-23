// To parse this JSON data, do
//
//     final debtListdata = debtListdataFromJson(jsonString);

import 'dart:convert';

List<DebtListdata> debtListdataFromJson(String str) => List<DebtListdata>.from(json.decode(str).map((x) => DebtListdata.fromJson(x)));

String debtListdataToJson(List<DebtListdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DebtListdata {
    DebtListdata({
        this.id,
        this.name,
        this.userId,
        this.dataId,
        this.total,
        this.waitingConfirmation,
        this.debtListdatumReturn,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    int userId;
    int dataId;
    int total;
    dynamic waitingConfirmation;
    DateTime debtListdatumReturn;
    DateTime createdAt;
    DateTime updatedAt;

    factory DebtListdata.fromJson(Map<String, dynamic> json) => DebtListdata(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        dataId: json["data_id"],
        total: json["total"],
        waitingConfirmation: json["waiting_confirmation"],
        debtListdatumReturn: DateTime.parse(json["return"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "data_id": dataId,
        "total": total,
        "waiting_confirmation": waitingConfirmation,
        "return": "${debtListdatumReturn.year.toString().padLeft(4, '0')}-${debtListdatumReturn.month.toString().padLeft(2, '0')}-${debtListdatumReturn.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
