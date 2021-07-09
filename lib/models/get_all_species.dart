// To parse this JSON data, do
//
//     final getAllSpeciesResponse = getAllSpeciesResponseFromJson(jsonString);

import 'dart:convert';

List<String> getAllSpeciesResponseFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String getAllSpeciesResponseToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
