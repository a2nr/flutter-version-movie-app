import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class _FetchHelper {
  String body;
  String type;

  _FetchHelper(this.body, this.type);
}

class MovieData {
  int idMovie;
  String type;
  String title;
  double averageVote;
  String pathBackdrop;
  String pathPoster;
  String releaseData;
  String language;

  final _keyApi = "a1eea6d03b1f0244d15177fec40aeb61";

  MovieData(
      {this.idMovie,
      this.type,
      this.title,
      this.releaseData,
      this.pathBackdrop,
      this.pathPoster,
      this.language,
      this.averageVote});

  Future<MovieData> fetchMovieData(
      String type, int id, http.Client client) async {
    final responseBody = await client
        .get('https://api.themoviedb.org/3/$type/$id?api_key=$_keyApi');
    final helper = _FetchHelper(responseBody.body, type);
    return compute(_parseBody, helper);
  }

  factory MovieData._fromJson(String type, Map<String, dynamic> json) {
    return MovieData(
        type: type,
        idMovie: json['id'] as int,
        title: json['title'] as String,
        averageVote: json['vote_average'] as double,
        language: json['original_language'] as String,
        pathBackdrop: json['backdrop_path'] as String,
        releaseData: json['release_date'] as String,
        pathPoster: json['poster_path'] as String);
  }

  static MovieData _parseBody(_FetchHelper arg) {
    final p = json.decode(arg.body);
    return MovieData._fromJson(arg.type, p as Map<String, dynamic>);
  }
}
