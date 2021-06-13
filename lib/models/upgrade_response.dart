// To parse this JSON data, do
//
//     final upgradeResponse = upgradeResponseFromJson(jsonString);

import 'dart:convert';

UpgradeResponse upgradeResponseFromJson(String str) => UpgradeResponse.fromJson(json.decode(str));

String upgradeResponseToJson(UpgradeResponse data) => json.encode(data.toJson());

class UpgradeResponse {
    UpgradeResponse({
        this.validToken,
        this.message,
        this.user,
    });

    bool validToken;
    String message;
    User user;

    factory UpgradeResponse.fromJson(Map<String, dynamic> json) => UpgradeResponse(
        validToken: json["validToken"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "validToken": validToken,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.typeAccount,
        this.isDeleted,
        this.isOnline,
        this.emailConfirmed,
        this.premium,
        this.datePlan,
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
    List<DateTime> datePlan;
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
        datePlan: List<DateTime>.from(json["datePlan"].map((x) => DateTime.parse(x))),
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
        "datePlan": List<dynamic>.from(datePlan.map((x) => x.toIso8601String())),
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
