
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/view/ItemView.dart';

void main() {
  testWidgets(
      "ItemView Widget Test",
      (WidgetTester tester) => provideMockedNetworkImages(() async {
            final mapJsonResponse = {
              "id": 18491,
              "title": "Neon Genesis Evangelion: The End of Evangelion",
              "vote_average": 8.4,
              "original_language": "ja",
              "backdrop_path": "/zguc4BSy4cbviHd7di67kifnmzD.jpg",
              "release_date": "1997-07-19",
              "poster_path": "/abTBQSq28KU5JhLN6iygcrOx03I.jpg"
            };
            final data = MovieData.fromJson(mapJsonResponse);
            await tester.pumpWidget(ItemView(data));
            final title =
                find.text("Neon Genesis Evangelion: The End of Evangelion");
            expect(title, findsOneWidget);
          }));
}
