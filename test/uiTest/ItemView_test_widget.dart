import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:movie_app/view/ItemView.dart';

class MockClient extends Mock implements Client {}

void main() {
  group("TEST ItemView Widget", () {
    final mapJsonResponse = {
      "id": 18491,
      "title": "Neon Genesis Evangelion: The End of Evangelion",
      "vote_average": 8.4,
      "original_language": "ja",
      "backdrop_path": "/this-image-never-be-loader.jpg",
      "release_date": "1997-07-19",
      "poster_path": "/this-image-never-be-loader.jpg",
      "original_title": "THE END OF EVANGELION",
      "popularity": 10.446,
      "spoken_languages": [
        {"iso_639_1": "ja", "name": "javancovok"}
      ],
      "overview":
          "The second of two theatrically released follow-ups to the Neon Genesis Evangelion series. Comprising of two alternate episodes which were first intended to take the place of episodes 25 and 26, this finale answers many of the questions surrounding the series, while also opening up some new possibilities.",
    };
    testWidgets("Main Item View Test", (WidgetTester tester) async {
      final data = MovieData.fromJson(mapJsonResponse);
      await tester.pumpWidget(ItemView(data));
      final title = find.text("Neon Genesis Evangelion: The End of Evangelion");
      expect(title, findsOneWidget);
    });

    testWidgets("Navigate to detail view Test", (WidgetTester tester) async {
      final keyApi = "a1eea6d03b1f0244d15177fec40aeb61";
      final client = MockClient();
      MovieData data = MovieData.fromJson(mapJsonResponse);

      when(client.get(
              RepositoryMovieData.getMovieDataLink(TypeMovie.MOVIE, 18491) +
                  "?api_key=$keyApi"))
          .thenAnswer((_) async {
        String res = json.encode(mapJsonResponse);
        return Response(res, 200);
      });
      await tester.pumpWidget(MaterialApp(
        title: "TEST NAVIGATION",
        home: ItemView(
          data,
          type: TypeMovie.MOVIE,
          client: client,
        ),
      ));
      var title = find.text("Neon Genesis Evangelion: The End of Evangelion");
      expect(title, findsOneWidget);
      await tester.tap(find.byKey(Key("Clickable_ItemView")));
      await tester.pumpAndSettle();
      var text = find.text(mapJsonResponse["overview"]);
      expect(text, findsOneWidget);
      text = find.text(mapJsonResponse["original_title"]);
      expect(text, findsOneWidget);
    });
  });
}
