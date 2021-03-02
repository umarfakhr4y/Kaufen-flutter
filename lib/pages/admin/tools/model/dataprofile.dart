// To parse this JSON data, do
//
//     final dataProfile = dataProfileFromJson(jsonString);

import 'dart:convert';

List<DataProfile> dataProfileFromJson(String str) => List<DataProfile>.from(json.decode(str).map((x) => DataProfile.fromJson(x)));

String dataProfileToJson(List<DataProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataProfile {
    DataProfile({
        this.name,
        this.alamat,
        this.noTelp,
        this.tanggalLahir,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.loans,
        this.deposit,
        this.barang,
    });

    String name;
    String alamat;
    String noTelp;
    DateTime tanggalLahir;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> loans;
    List<dynamic> deposit;
    List<dynamic> barang;

    factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
        name: json["name"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loans: List<dynamic>.from(json["loans"].map((x) => x)),
        deposit: List<dynamic>.from(json["deposit"].map((x) => x)),
        barang: List<dynamic>.from(json["barang"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "no_telp": noTelp,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loans": List<dynamic>.from(loans.map((x) => x)),
        "deposit": List<dynamic>.from(deposit.map((x) => x)),
        "barang": List<dynamic>.from(barang.map((x) => x)),
    };
}
