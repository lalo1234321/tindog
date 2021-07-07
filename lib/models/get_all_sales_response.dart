// To parse this JSON data, do
//
//     final getAllSalesResponse = getAllSalesResponseFromJson(jsonString);

import 'dart:convert';

GetAllSalesResponse getAllSalesResponseFromJson(String str) => GetAllSalesResponse.fromJson(json.decode(str));

String getAllSalesResponseToJson(GetAllSalesResponse data) => json.encode(data.toJson());

class GetAllSalesResponse {
    GetAllSalesResponse({
        this.sales,
    });

    List<Sale> sales;

    factory GetAllSalesResponse.fromJson(Map<String, dynamic> json) => GetAllSalesResponse(
        sales: List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sales": List<dynamic>.from(sales.map((x) => x.toJson())),
    };
}

class Sale {
    Sale({
        this.location,
        this.idBuyer,
        this.status,
        this.id,
        this.pet,
        this.price,
        this.idSeller,
        this.date,
        this.v,
    });

    String location;
    dynamic idBuyer;
    String status;
    String id;
    Pet pet;
    double price;
    IdSeller idSeller;
    DateTime date;
    int v;

    factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        location: json["location"],
        idBuyer: json["idBuyer"],
        status: json["status"],
        id: json["_id"],
        pet: Pet.fromJson(json["pet"]),
        price: json["price"].toDouble(),
        idSeller: IdSeller.fromJson(json["idSeller"]),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "location": location,
        "idBuyer": idBuyer,
        "status": status,
        "_id": id,
        "pet": pet.toJson(),
        "price": price,
        "idSeller": idSeller.toJson(),
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class IdSeller {
    IdSeller({
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

    factory IdSeller.fromJson(Map<String, dynamic> json) => IdSeller(
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

class Pet {
    Pet({
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
    double stars;
    int meetingsNumber;
    List<String> previousMeetings;
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

    factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        breed: json["breed"],
        vaccines: List<String>.from(json["vaccines"].map((x) => x)),
        isDeleted: json["isDeleted"],
        stars: json["stars"].toDouble(),
        meetingsNumber: json["meetingsNumber"],
        previousMeetings: List<String>.from(json["previousMeetings"].map((x) => x)),
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
