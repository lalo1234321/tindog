// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.user,
        this.token,
    });

    User user;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.typeAccount,
        this.isDeleted,
        this.isOnline,
        this.emailConfirmed,
        this.premium,
        this.ownedPets,
        this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.email,
        this.password,
        this.age,
        this.state,
        this.town,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String typeAccount;
    bool isDeleted;
    bool isOnline;
    bool emailConfirmed;
    bool premium;
    List<String> ownedPets;
    String id;
    String firstName;
    String lastName;
    String userName;
    String email;
    String password;
    int age;
    String state;
    String town;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory User.fromJson(Map<String, dynamic> json) => User(
        typeAccount: json["typeAccount"],
        isDeleted: json["isDeleted"],
        isOnline: json["isOnline"],
        emailConfirmed: json["emailConfirmed"],
        premium: json["premium"],
        ownedPets: List<String>.from(json["ownedPets"].map((x) => x)),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        age: json["age"],
        state: json["state"],
        town: json["town"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "typeAccount": typeAccount,
        "isDeleted": isDeleted,
        "isOnline": isOnline,
        "emailConfirmed": emailConfirmed,
        "premium": premium,
        "ownedPets": List<dynamic>.from(ownedPets.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "email": email,
        "password": password,
        "age": age,
        "state": state,
        "town": town,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
