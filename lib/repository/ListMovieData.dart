import 'MovieData.dart';

class ListMovieData {
  int page;
  List<MovieData> results;
  int totalPages;
  int totalResults;

  ListMovieData({this.page, this.results, this.totalPages, this.totalResults});

  factory ListMovieData.fromJson(Map<String, dynamic> map) {
    int page = map['page'];
    List<MovieData> results;
    if (map['results'] != null) {
      results = new List<MovieData>();
      map['results'].forEach((v) {
        results.add(new MovieData.fromJson(v));
      });
    }
    int totalPages = map['total_pages'];
    int totalResults = map['total_results'];
    return ListMovieData(
        page: page,
        results: results,
        totalPages: totalPages,
        totalResults: totalResults);
  }
}
