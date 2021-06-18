// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

NotificationsResponse notificationsResponseFromJson(String str) => NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) => json.encode(data.toJson());

class NotificationsResponse {
    NotificationsResponse({
        this.results,
    });

    List<Result> results;

    factory NotificationsResponse.fromJson(Map<String, dynamic> json) => NotificationsResponse(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.accepted,
        this.id,
        this.to,
        this.from,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    bool accepted;
    String id;
    String to;
    String from;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        accepted: json["accepted"],
        id: json["_id"],
        to: json["to"],
        from: json["from"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "accepted": accepted,
        "_id": id,
        "to": to,
        "from": from,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
