import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:movie_app/view/ListItemView.dart';

void main() => runApp(MyMovieApp());

class MovieMenu {
  final String type;
  final String title;
  final IconData icon;

  const MovieMenu._internal(this.type, this.title, this.icon);
  @override
  String toString() => "MovieMenu.$type";

  static const Movie =
      const MovieMenu._internal(TypeMovie.MOVIE, "Movie", Icons.movie);
  static const TvShow =
      const MovieMenu._internal(TypeMovie.TV, "Tv Show", Icons.live_tv);
}

class MyMovieApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyMovieApp();
}

class _MyMovieApp extends State<MyMovieApp> {
  // This widget is the root of your application.
  MovieMenu _curentMenu = MovieMenu.Movie;

  // @override
  // void initState() {
  //   super.initState();
  //   _curentMenu = MovieMenu.Movie;
  // }

  PopupMenuItem<MovieMenu> _makeRowMenu(
      MovieMenu value, IconData icon, String text) {
    return PopupMenuItem<MovieMenu>(
        value: value,
        child: Row(children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 8,
          ),
          Text(text)
        ]));
  }

  PopupMenuButton<MovieMenu> _buildMenu() {
    return PopupMenuButton<MovieMenu>(
        onSelected: (stateNow) {
          print("Menu selected to ${stateNow.type}");
          setState(() {
            _curentMenu = stateNow;
          });
        },
        icon: Icon(_curentMenu.icon),
        elevation: 3,
        offset: Offset(0, kToolbarHeight * 2),
        itemBuilder: (BuildContext context) => <PopupMenuItem<MovieMenu>>[
              _makeRowMenu(
                  MovieMenu.Movie, MovieMenu.Movie.icon, MovieMenu.Movie.title),
              _makeRowMenu(MovieMenu.TvShow, MovieMenu.TvShow.icon,
                  MovieMenu.TvShow.title),
            ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Belajar Flutter',
        home: Center(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(_curentMenu.title),
                  leading: _buildMenu(),
                ),
                body: ListItemViewFactory.widget(
                    type: _curentMenu.type,
                    categories: CategoriesMovie.TRENDING,
                    client: Client()))));
  }
}
