import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

void main() {
  test("Get single movie data from api.themoviedb.org", () async {
    var data =
        await RepositoryMovieData(Client()).fetchMovieData("movie", 18491);
    expect(data.title, "Neon Genesis Evangelion: The End of Evangelion");
  });
}
