import 'package:flutter/material.dart';
import 'package:movie_app/repository/ListMovieData.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:movie_app/view/ItemView.dart';
import 'package:paging/paging.dart';

class _ListItemView extends State<ListItemView> {
  final type, categorie, client;

  _ListItemView(this.type, this.categorie, this.client);

  Widget _listViewBuilder(ListMovieData data) {
    return Pagination<MovieData>(
      scrollDirection: Axis.vertical,
      progress: LinearProgressIndicator(),
      pageBuilder: (curentPage) async {
        final data = await RepositoryMovieData(client)
            .fetchListMovieData(type, categorie, curentPage + 1);
        return data.results;
      },
      itemBuilder: (index, data) => ItemView(data),
    );
  }

  Widget _futureBuilderListMovie(BuildContext context) {
    return FutureBuilder(
      future: RepositoryMovieData(client)
          .fetchListMovieData(type, CategoriesMovie.TRENDING, 1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              ListMovieData data = snapshot.data;
              return Center(child: _listViewBuilder(data));
              // return ItemView(data.results[0].id, type, client);
            }
            continue nodata;
          nodata:
          case ConnectionState.none:
            return Row(children: <Widget>[
              Icon(Icons.report_problem),
              Text("Check your connection.")
            ]);
          default:
            return LinearProgressIndicator();
        }
        return LinearProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: _futureBuilderListMovie(context));
  }
}

class ListItemView extends StatefulWidget {
  final type, categories, client;
  ListItemView(this.type, this.categories, this.client);
  @override
  State<StatefulWidget> createState() =>
      _ListItemView(this.type, this.categories, this.client);
}
