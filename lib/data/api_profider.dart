
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/mode/popular_movie.dart';

class ApiProvider { 
  //api key dari browser
  String apiKey = '6fd77c5ba4385bd571dda4eb8665224a'; 
  String baseUrl = 'https://api.themoviedb.org/3/movie/popular?';
  late int id; 

  Future<PopularMovie> getMovies() async{
    var response = await http.get(Uri.parse("${baseUrl}api_key=$apiKey"));
    return PopularMovie.fromJson(jsonDecode(response.body));
  }
}

