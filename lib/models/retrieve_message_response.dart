// To parse this JSON data, do
//
//     final retrieveMessageResponse = retrieveMessageResponseFromJson(jsonString);

import 'dart:convert';

RetrieveMessageResponse retrieveMessageResponseFromJson(String str) => RetrieveMessageResponse.fromJson(json.decode(str));

String retrieveMessageResponseToJson(RetrieveMessageResponse data) => json.encode(data.toJson());

class RetrieveMessageResponse {
    RetrieveMessageResponse({
        this.message,
        this.last30,
    });

    String message;
    List<Last30> last30;

    factory RetrieveMessageResponse.fromJson(Map<String, dynamic> json) => RetrieveMessageResponse(
        message: json["message"],
        last30: List<Last30>.from(json["last30"].map((x) => Last30.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "last30": List<dynamic>.from(last30.map((x) => x.toJson())),
    };
}

class Last30 {
    Last30({
        this.id,
        this.from,
        this.to,
        this.msg,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String from;
    String to;
    String msg;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Last30.fromJson(Map<String, dynamic> json) => Last30(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
