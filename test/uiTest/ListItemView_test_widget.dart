import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:movie_app/view/ListItemView.dart';

void main() {
  testWidgets("Test ListItemView() widget !", (WidgetTester tester) async {
    var clientMock = MockClient((request) async {
      final mapJson = {
        "page": 1,
        "results": [
          {
            "id": 420809,
            "video": false,
            "vote_count": 1286,
            "vote_average": 7.2,
            "title": "Maleficent: Mistress of Evil",
            "release_date": "2019-10-16",
            "original_language": "en",
            "original_title": "Maleficent: Mistress of Evil",
            "backdrop_path": "/unknown.jpg",
            "adult": false,
            "overview":
                "Maleficent and her goddaughter Aurora begin to question the complex family ties that bind them as they are pulled in different directions by impending nuptials, unexpected allies, and dark new forces at play.",
            "poster_path": "/unknown.jpg",
            "popularity": 200.703,
            "media_type": "movie"
          },
          {
            "id": 475557,
            "video": false,
            "vote_count": 7539,
            "vote_average": 8.3,
            "title": "Joker",
            "release_date": "2019-10-02",
            "original_language": "en",
            "original_title": "Joker",
            "backdrop_path": "/unknown.jpg",
            "adult": false,
            "overview":
                "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
            "poster_path": "/unknown.jpg",
            "popularity": 224.98,
            "media_type": "movie"
          }
        ],
        "total_pages": 1000,
        "total_results": 20000
      };
      final sendResponse = json.encode(mapJson);
      return Response(sendResponse, 200);
    });
    await tester.pumpWidget(ListItemViewFactory.widget(
        type: TypeMovie.MOVIE,
        categories: CategoriesMovie.TRENDING,
        client: clientMock));

    await tester.pumpAndSettle();
    var title = find.text("Maleficent: Mistress of Evil");
    expect(title, findsOneWidget);
    title = find.text("Joker");
    expect(title, findsOneWidget);
  });
}
