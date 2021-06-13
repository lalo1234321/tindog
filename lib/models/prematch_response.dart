// To parse this JSON data, do
//
//     final preMatchResponse = preMatchResponseFromJson(jsonString);

import 'dart:convert';

PreMatchResponse preMatchResponseFromJson(String str) => PreMatchResponse.fromJson(json.decode(str));

String preMatchResponseToJson(PreMatchResponse data) => json.encode(data.toJson());

class PreMatchResponse {
    PreMatchResponse({
        this.validToken,
        this.message,
        this.match,
    });

    bool validToken;
    String message;
    List<Match> match;

    factory PreMatchResponse.fromJson(Map<String, dynamic> json) => PreMatchResponse(
        validToken: json["validToken"],
        message: json["message"],
        match: List<Match>.from(json["match"].map((x) => Match.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "validToken": validToken,
        "message": message,
        "match": List<dynamic>.from(match.map((x) => x.toJson())),
    };
}

class Match {
    Match({
        this.breed,
        this.vaccines,
        this.isDeleted,
        this.id,
        this.username,
        this.name,
        this.age,
        this.specie,
        this.gender,
        this.profileImagePhysicalPath,
        this.medicalCertificateImagePhysicalPath,
        this.profileImageUri,
        this.medicalCertificateImageUri,
        this.owner,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String breed;
    List<String> vaccines;
    bool isDeleted;
    String id;
    String username;
    String name;
    int age;
    String specie;
    String gender;
    String profileImagePhysicalPath;
    String medicalCertificateImagePhysicalPath;
    String profileImageUri;
    String medicalCertificateImageUri;
    Owner owner;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        breed: json["breed"],
        vaccines: List<String>.from(json["vaccines"].map((x) => x)),
        isDeleted: json["isDeleted"],
        id: json["_id"],
        username: json["username"],
        name: json["name"],
        age: json["age"],
        specie: json["specie"],
        gender: json["gender"],
        profileImagePhysicalPath: json["profileImagePhysicalPath"],
        medicalCertificateImagePhysicalPath: json["medicalCertificateImagePhysicalPath"],
        profileImageUri: json["profileImageURI"],
        medicalCertificateImageUri: json["medicalCertificateImageURI"],
        owner: Owner.fromJson(json["owner"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "breed": breed,
        "vaccines": List<dynamic>.from(vaccines.map((x) => x)),
        "isDeleted": isDeleted,
        "_id": id,
        "username": username,
        "name": name,
        "age": age,
        "specie": specie,
        "gender": gender,
        "profileImagePhysicalPath": profileImagePhysicalPath,
        "medicalCertificateImagePhysicalPath": medicalCertificateImagePhysicalPath,
        "profileImageURI": profileImageUri,
        "medicalCertificateImageURI": medicalCertificateImageUri,
        "owner": owner.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Owner {
    Owner({
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

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
