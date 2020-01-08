import 'package:http/http.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:test/test.dart';

void main() {
  test("Get List of data from api.themoviedb.org", () async {
    final data = await RepositoryMovieData(Client())
        .fetchListMovieData(TypeMovie.MOVIE, CategoriesMovie.TRENDING, 1);
    expect(data.results.length, 20);
    expect(data.totalPages, 1000);
  });
}
