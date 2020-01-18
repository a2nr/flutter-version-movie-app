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

  static String getMovieDataLink(String type, int id) =>
      'https://api.themoviedb.org/3/$type/$id';
  static String getTrendingLink(String type, String categories) =>
      'https://api.themoviedb.org/3/$categories/$type/day';

  static MovieData dummyMovieData(){
    final mapJsonResponse = {
      "adult": false,
      "backdrop_path": "/AfyuI3glMCBDFmNPj9PY6DwbgGp.jpg",
      "belongs_to_collection": {
        "id": 96850,
        "name": "Evangelion Collection",
        "poster_path": "/abTBQSq28KU5JhLN6iygcrOx03I.jpg",
        "backdrop_path": "/zguc4BSy4cbviHd7di67kifnmzD.jpg"
      },
      "budget": 0,
      "genres": [
        {
          "id": 18,
          "name": "Drama"
        },
        {
          "id": 878,
          "name": "Science Fiction"
        },
        {
          "id": 16,
          "name": "Animation"
        }
      ],
      "homepage": null,
      "id": 18491,
      "imdb_id": "tt0169858",
      "original_language": "ja",
      "original_title": "THE END OF EVANGELION",
      "overview": "The second of two theatrically released follow-ups to the Neon Genesis Evangelion series. Comprising of two alternate episodes which were first intended to take the place of episodes 25 and 26, this finale answers many of the questions surrounding the series, while also opening up some new possibilities.",
      "popularity": 12.624,
      "poster_path": "/5JYzfyKBwReaQ41WFhqXgOZnPWV.jpg",
      "production_companies": [
        {
          "id": 3041,
          "logo_path": "/j9VqEdiNqIkMJKku1UTGMAvmuRr.png",
          "name": "GAINAX",
          "origin_country": "JP"
        },
        {
          "id": 3466,
          "logo_path": "/3SjyGEs9xWPw0fEXKVp1HOnJ5t2.png",
          "name": "Movic",
          "origin_country": "JP"
        },
        {
          "id": 21504,
          "logo_path": null,
          "name": "Star Child Recording",
          "origin_country": ""
        },
        {
          "id": 3034,
          "logo_path": "/kGRavMqgyx4p2X4C96bjRCj50oI.png",
          "name": "TV Tokyo",
          "origin_country": "JP"
        },
        {
          "id": 529,
          "logo_path": "/rwB6w2aPENQbx756pBWSw44Ouk.png",
          "name": "Production I.G",
          "origin_country": "JP"
        },
        {
          "id": 1194,
          "logo_path": null,
          "name": "Kadokawa Shoten Publishing",
          "origin_country": "JP"
        },
        {
          "id": 5822,
          "logo_path": "/qyTbRgCyU9NLKvKaiQVbadtr7RY.png",
          "name": "Toei Company, Ltd.",
          "origin_country": "JP"
        },
        {
          "id": 113750,
          "logo_path": "/A3QVZ9Ah0yI2d2GiXUFpdlbTgyr.png",
          "name": "SEGA",
          "origin_country": "JP"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "JP",
          "name": "Japan"
        }
      ],
      "release_date": "1997-07-19",
      "revenue": 20000000,
      "runtime": 87,
      "spoken_languages": [
        {
          "iso_639_1": "ja",
          "name": "unknown"
        }
      ],
      "status": "Released",
      "tagline": "The fate of destruction is also the joy of rebirth",
      "title": "Neon Genesis Evangelion: The End of Evangelion",
      "video": false,
      "vote_average": 8.4,
      "vote_count": 456
    };
    return MovieData.fromJson(mapJsonResponse);
  }
  static MovieData _parseMovieDataBody(String body) {
    Map<String, dynamic> map = json.decode(body);
    return MovieData.fromJson(map);
  }

  static ListMovieData _parseListMovieDataBody(String body) {
    Map<String, dynamic> map = json.decode(body);
    return ListMovieData.fromJson(map);
  }

  Future<MovieData> fetchMovieData(String type, int id) async {
    final responseBody =
        await client.get(getMovieDataLink(type, id) + "?api_key=$_keyApi");
    print(getMovieDataLink(type, id) + "?api_key=$_keyApi");
    return compute(_parseMovieDataBody, responseBody.body);
  }

  Future<ListMovieData> fetchListMovieData(
      String type, String categories, int page) async {
    final responseBody = await client.get(
        getTrendingLink(type, categories) + '?page=$page&api_key=$_keyApi');
    print(getTrendingLink(type, categories) + '?page=$page&api_key=$_keyApi');
    return compute(_parseListMovieDataBody, responseBody.body);
  }
}
