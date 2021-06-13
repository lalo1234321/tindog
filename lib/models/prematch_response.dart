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
    String owner;
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
        owner: json["owner"],
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
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
