// To parse this JSON data, do
//
//     final getAllMyChatsForSaleResponse = getAllMyChatsForSaleResponseFromJson(jsonString);

import 'dart:convert';

GetAllMyChatsForSaleResponse getAllMyChatsForSaleResponseFromJson(String str) => GetAllMyChatsForSaleResponse.fromJson(json.decode(str));

String getAllMyChatsForSaleResponseToJson(GetAllMyChatsForSaleResponse data) => json.encode(data.toJson());

class GetAllMyChatsForSaleResponse {
    GetAllMyChatsForSaleResponse({
        this.chats,
    });

    List<Chat> chats;

    factory GetAllMyChatsForSaleResponse.fromJson(Map<String, dynamic> json) => GetAllMyChatsForSaleResponse(
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    };
}

class Chat {
    Chat({
        this.id,
        this.idComprador,
        this.idVendedor,
        this.topic,
        this.v,
    });

    String id;
    IdDor idComprador;
    IdDor idVendedor;
    String topic;
    int v;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        idComprador: IdDor.fromJson(json["idComprador"]),
        idVendedor: IdDor.fromJson(json["idVendedor"]),
        topic: json["topic"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "idComprador": idComprador.toJson(),
        "idVendedor": idVendedor.toJson(),
        "topic": topic,
        "__v": v,
    };
}

class IdDor {
    IdDor({
        this.typeAccount,
        this.isDeleted,
        this.isOnline,
        this.emailConfirmed,
        this.premium,
        this.datePlan,
        this.ownedPets,
        this.auxLastConnection,
        this.deviceInformation,
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
    dynamic auxLastConnection;
    dynamic deviceInformation;
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

    factory IdDor.fromJson(Map<String, dynamic> json) => IdDor(
        typeAccount: json["typeAccount"],
        isDeleted: json["isDeleted"],
        isOnline: json["isOnline"],
        emailConfirmed: json["emailConfirmed"],
        premium: json["premium"],
        datePlan: List<DateTime>.from(json["datePlan"].map((x) => DateTime.parse(x))),
        ownedPets: List<String>.from(json["ownedPets"].map((x) => x)),
        auxLastConnection: json["auxLastConnection"],
        deviceInformation: json["deviceInformation"],
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
        "auxLastConnection": auxLastConnection,
        "deviceInformation": deviceInformation,
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
