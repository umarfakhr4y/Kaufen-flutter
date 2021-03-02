// To parse this JSON data, do
//
//     final memberListSIngle = memberListSIngleFromJson(jsonString);

import 'dart:convert';

List<MemberListSIngle> memberListSIngleFromJson(String str) => List<MemberListSIngle>.from(json.decode(str).map((x) => MemberListSIngle.fromJson(x)));

String memberListSIngleToJson(List<MemberListSIngle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberListSIngle {
    MemberListSIngle({
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
    List<Loan> loans;
    List<Deposit> deposit;
    List<Barang> barang;

    factory MemberListSIngle.fromJson(Map<String, dynamic> json) => MemberListSIngle(
        name: json["name"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loans: List<Loan>.from(json["loans"].map((x) => Loan.fromJson(x))),
        deposit: List<Deposit>.from(json["deposit"].map((x) => Deposit.fromJson(x))),
        barang: List<Barang>.from(json["barang"].map((x) => Barang.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "no_telp": noTelp,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loans": List<dynamic>.from(loans.map((x) => x.toJson())),
        "deposit": List<dynamic>.from(deposit.map((x) => x.toJson())),
        "barang": List<dynamic>.from(barang.map((x) => x.toJson())),
    };
}
class Loan {
    Loan({
        this.id,
        this.name,
        this.total,
        this.loanReturn,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    int total;
    DateTime loanReturn;
    DateTime createdAt;
    DateTime updatedAt;

    factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        loanReturn: DateTime.parse(json["return"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total": total,
        "return": "${loanReturn.year.toString().padLeft(4, '0')}-${loanReturn.month.toString().padLeft(2, '0')}-${loanReturn.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Barang {
    Barang({
        this.id,
        this.name,
        this.nameBarang,
        this.stock,
        this.jenis,
        this.harga,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String nameBarang;
    int stock;
    String jenis;
    int harga;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        id: json["id"],
        name: json["name"],
        nameBarang: json["name_barang"],
        stock: json["stock"],
        jenis: json["jenis"],
        harga: json["harga"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_barang": nameBarang,
        "stock": stock,
        "jenis": jenis,
        "harga": harga,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Deposit {
    Deposit({
        this.id,
        this.name,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.depositReturn,
    });

    int id;
    String name;
    int total;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime depositReturn;

    factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        depositReturn: json["return"] == null ? null : DateTime.parse(json["return"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "return": depositReturn == null ? null : "${depositReturn.year.toString().padLeft(4, '0')}-${depositReturn.month.toString().padLeft(2, '0')}-${depositReturn.day.toString().padLeft(2, '0')}",
    };
}
