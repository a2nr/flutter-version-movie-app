import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:movie_app/view/DetailItemView.dart';

void main() {
  testWidgets("ItemView Widget Test", (WidgetTester tester) async {
    await tester.runAsync(() async {
      final mapJsonResponse = {
        "id": 18491,
        "title": "Neon Genesis Evangelion: The End of Evangelion",
        "vote_average": 8.4,
        "original_language": "ja",
        "backdrop_path": "/unknown.jpg",
        "release_date": "1997-07-19",
        "poster_path": "/unknown.jpg",
        "original_title": "THE END OF EVANGELION",
        "popularity": 10.446,
        "spoken_languages": [
          {"iso_639_1": "ja", "name": "javancovok"}
        ],
        "overview":
            "The second of two theatrically released follow-ups to the Neon Genesis Evangelion series. Comprising of two alternate episodes which were first intended to take the place of episodes 25 and 26, this finale answers many of the questions surrounding the series, while also opening up some new possibilities.",
      };
      await tester.pumpWidget(MaterialApp(
          title: 'Belajar Flutter',
          home: Center(
              child: DetailItemView("movie", 18491, MockClient((request) async {
            String res = json.encode(mapJsonResponse);
            return Response(res, 200);
          })))));
      await tester.pumpAndSettle();

      var text = find.text(mapJsonResponse["overview"]);
      expect(text, findsOneWidget);
      text = find.text(mapJsonResponse["original_title"]);
      expect(text, findsOneWidget);
      // final title = find.byKey(Key("main_title"));
      // expect(mapJsonResponse["title"], title);
    });
  });
}
