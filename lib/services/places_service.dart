import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:tindog/models/place.dart';


class PlacesService {
  final key = 'AIzaSyDierkxutrp74tCCoyQ4k1iWOJw8h1KtaM';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=veterinary_care&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}
