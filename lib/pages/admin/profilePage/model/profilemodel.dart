// To parse this JSON data, do
//
//     final dataLogin = dataLoginFromJson(jsonString);

import 'dart:convert';

DataLogin dataLoginFromJson(String str) => DataLogin.fromJson(json.decode(str));

String dataLoginToJson(DataLogin data) => json.encode(data.toJson());

class DataLogin {
    DataLogin({
        this.success,
    });

    Success success;

    factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    Success({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.data,
    });

    int id;
    String name;
    String email;
    DateTime emailVerifiedAt;
    String image;
    DateTime createdAt;
    DateTime updatedAt;
    List<String> role;
    List<Datum> data;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: List<String>.from(json["role"].map((x) => x)),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": List<dynamic>.from(role.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.alamat,
        this.noTelp,
        this.tanggalLahir,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String alamat;
    String noTelp;
    DateTime tanggalLahir;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alamat": alamat,
        "no_telp": noTelp,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
