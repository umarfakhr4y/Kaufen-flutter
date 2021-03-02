// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

part of "model.dart";

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
    Token({
        this.success,
    });

    Success success;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    Success({
        this.token,
    });

    String token;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
