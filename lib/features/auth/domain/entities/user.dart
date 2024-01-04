import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final Data data;
    final int? expirationDate;
    final String? token;
    final String? message;

    User({
        required this.data,
        this.expirationDate,
        this.token,
        required this.message,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        data: Data.fromJson(json["data"]),
        expirationDate: json["expiration_date"],
        token: json["token"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "expiration_date": expirationDate,
        "token": token,
        "message": message,
    };
}

class Data {
    final UserClass user;

    Data({
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: UserClass.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class UserClass {
    final String id;
    final String name;
    final String username;
    final String password;
    final String email;
    final Merchant merchant;

    UserClass({
        required this.id,
        required this.name,
        required this.username,
        required this.password,
        required this.email,
        required this.merchant,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        merchant: Merchant.fromJson(json["merchant"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "password": password,
        "email": email,
        "merchant": merchant.toJson(),
    };
}

class Merchant {
    final String id;
    final String name;
    final String rnc;
    final String phone;
    final String email;
    final String slogan;
    final String address;
    final String webUrl;
    final String logoUrl;
    final bool status;
    final String longitude;
    final String latitude;
    final int v;

    Merchant({
        required this.id,
        required this.name,
        required this.rnc,
        required this.phone,
        required this.email,
        required this.slogan,
        required this.address,
        required this.webUrl,
        required this.logoUrl,
        required this.status,
        required this.longitude,
        required this.latitude,
        required this.v,
    });

    factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["_id"],
        name: json["name"],
        rnc: json["rnc"],
        phone: json["phone"],
        email: json["email"],
        slogan: json["slogan"],
        address: json["address"],
        webUrl: json["web_url"],
        logoUrl: json["logo_url"],
        status: json["status"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "rnc": rnc,
        "phone": phone,
        "email": email,
        "slogan": slogan,
        "address": address,
        "web_url": webUrl,
        "logo_url": logoUrl,
        "status": status,
        "longitude": longitude,
        "latitude": latitude,
        "__v": v,
    };
}