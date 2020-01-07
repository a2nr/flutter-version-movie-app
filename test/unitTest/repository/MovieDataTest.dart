import 'package:movie_app/repository/MovieData.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

void main() {
  test("Get single movie data from api.themoviedb.org", () {
    final data = MovieData().fetchMovieData("movie", 18491, Client());
    data.then((MovieData data) {
      expect(data.title, "Neon Genesis Evangelion: The End of Evangelion");
    });
  });
}
