import 'package:http/http.dart' as http ;
import 'package:tindog/models/movie_response.dart';
import 'package:tindog/services/auth_service.dart';



class MovieService {
  
  Future<List<Result>> getMovies () async {
    try {
      final animal = await AuthService.getPetName();
      print(animal);
      final resp = await http.get('https://api.themoviedb.org/3/movie/now_playing?api_key=b3b63330b7a105a0aa4bdd7530d02cc0&language=es-ES');
      final movieResponse = movieResponseFromJson( resp.body );
      return movieResponse.results;
    } catch(e) {
      return [];
    }
  }
}