import 'dart:convert';

import 'package:movie_db/mode/film_populer.dart';
import 'package:http/http.dart' as http;

class Remote{
  Future<FilmPopuler> getFilmPopuler()async{
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=6fd77c5ba4385bd571dda4eb8665224a&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return filmPopulerFromJson(json);
    }else{
      throw Exception(response.statusCode);
    }
  }
}