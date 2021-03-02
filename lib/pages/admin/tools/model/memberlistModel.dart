// To parse this JSON data, do
//
//     final memberListmodel = memberListmodelFromJson(jsonString);

import 'dart:convert';

MemberListmodel memberListmodelFromJson(String str) => MemberListmodel.fromJson(json.decode(str));

String memberListmodelToJson(MemberListmodel data) => json.encode(data.toJson());

class MemberListmodel {
    MemberListmodel({
        this.user,
    });

    List<User> user;

    factory MemberListmodel.fromJson(Map<String, dynamic> json) => MemberListmodel(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
    };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.data,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> data;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        data: List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "data": List<dynamic>.from(data.map((x) => x)),
    };
}
