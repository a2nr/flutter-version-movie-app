import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:movie_app/repository/ListMovieData.dart';
import 'MovieData.dart';

class RepositoryMovieData {
  final Client client;
  final _keyApi = "a1eea6d03b1f0244d15177fec40aeb61";

  RepositoryMovieData(this.client);

  static String getImageLink(String width, String path) =>
      "https://image.tmdb.org/t/p/$width$path";

  static String getMovieDataLink(String type, int id) => 'https://api.themoviedb.org/3/$type/$id';
  static String getTrendingLink(String type, String categories) =>
        'https://api.themoviedb.org/3/$categories/$type/day';

  static MovieData _parseMovieDataBody(String body) {
    Map<String, dynamic> map = json.decode(body);
    return MovieData.fromJson(map);
  }
  static ListMovieData _parseListMovieDataBody(String body) {
    Map<String, dynamic> map = json.decode(body);
    return ListMovieData.fromJson(map);
  }

  Future<MovieData> fetchMovieData(String type, int id) async {
    final responseBody = await client
        .get(getMovieDataLink(type,id)+"?api_key=$_keyApi");
    return compute(_parseMovieDataBody, responseBody.body);
  }

  Future<ListMovieData> fetchListMovieData(
      String type, String categories, int page) async {
    final responseBody = await client.get(
        getTrendingLink(type, categories)+'?page=$page&api_key=$_keyApi');
    return compute(_parseListMovieDataBody, responseBody.body);
  }
}
