import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:movie_app/view/DetailItemView.dart';

void main() {
  testWidgets("ItemView Widget Test", (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MaterialApp(
          title: 'Belajar Flutter',
          home: Center(
              child: DetailItemView("movie", 18491, MockClient((request) async {
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
              "overview":
                  "The second of two theatrically released follow-ups to the Neon Genesis Evangelion series. Comprising of two alternate episodes which were first intended to take the place of episodes 25 and 26, this finale answers many of the questions surrounding the series, while also opening up some new possibilities.",
            };
            return Response(json.encode(mapJsonResponse), 200);
          })))));
      await tester.pumpAndSettle();

      final title = find.text("Neon Genesis Evangelion: The End of Evangelion");
      expect(title, findsOneWidget);
    });
  });
}
