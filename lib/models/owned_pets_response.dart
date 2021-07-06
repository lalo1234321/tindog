// To parse this JSON data, do
//
//     final ownedPetsResponse = ownedPetsResponseFromJson(jsonString);

import 'dart:convert';

List<OwnedPetsResponse> ownedPetsResponseFromJson(String str) => List<OwnedPetsResponse>.from(json.decode(str).map((x) => OwnedPetsResponse.fromJson(x)));

String ownedPetsResponseToJson(List<OwnedPetsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OwnedPetsResponse {
    OwnedPetsResponse({
        this.ownedPets,
    });

    List<OwnedPet> ownedPets;

    factory OwnedPetsResponse.fromJson(Map<String, dynamic> json) => OwnedPetsResponse(
        ownedPets: List<OwnedPet>.from(json["ownedPets"].map((x) => OwnedPet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ownedPets": List<dynamic>.from(ownedPets.map((x) => x.toJson())),
    };
}

class OwnedPet {
    OwnedPet({
        this.breed,
        this.vaccines,
        this.isDeleted,
        this.stars,
        this.meetingsNumber,
        this.previousMeetings,
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
    int stars;
    int meetingsNumber;
    List<dynamic> previousMeetings;
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

    factory OwnedPet.fromJson(Map<String, dynamic> json) => OwnedPet(
        breed: json["breed"],
        vaccines: List<String>.from(json["vaccines"].map((x) => x)),
        isDeleted: json["isDeleted"],
        stars: json["stars"],
        meetingsNumber: json["meetingsNumber"],
        previousMeetings: List<dynamic>.from(json["previousMeetings"].map((x) => x)),
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
        "stars": stars,
        "meetingsNumber": meetingsNumber,
        "previousMeetings": List<dynamic>.from(previousMeetings.map((x) => x)),
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
