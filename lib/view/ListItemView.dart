import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/repository/ListMovieData.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:movie_app/view/ItemView.dart';
import 'package:pagination_view/pagination_view.dart';

class ListItemViewFactory {
  static Widget widget({
    @required type,
    @required categories,
    @required client,
  }) =>
      _InheritageListItemView(
        categories: categories,
        client: client,
        type: type,
        child: _MainListItemView(),
      );
}

class _InheritageListItemView extends InheritedWidget {
  final String type;
  final String categories;
  final Client client;

  const _InheritageListItemView({
    Key key,
    @required this.type,
    @required this.categories,
    @required this.client,
    @required Widget child,
  })  : assert(type != null),
        assert(child != null),
        super(key: key, child: child);

  static _InheritageListItemView of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritageListItemView>();
  }

  @override
  bool updateShouldNotify(_InheritageListItemView oldWidget) {
    if (type != oldWidget.type) return true;
    if (categories != oldWidget.categories) return true;
    return false;
  }
}

class _ListItemView extends State<_MainListItemView> {
  Widget _futureBuilderListMovie(BuildContext context) {
    final param = _InheritageListItemView.of(context);
    return FutureBuilder<ListMovieData>(
      future: RepositoryMovieData(param.client)
          .fetchListMovieData(param.type, param.categories, 1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return PaginationView<MovieData>(
                onLoading: LinearProgressIndicator(),
                onError: (e) {
                  print("$e");
                  return Center(
                    child: Text("Fail get data"),
                  );
                },
                itemBuilder: (index, data) {
                  return ItemView(
                    data,
                    type: param.type,
                    client: param.client,
                  );
                },
                onEmpty: Center(
                  child: Icon(Icons.error_outline),
                ),
                pageFetch: (int currentListSize) async {
                  if (currentListSize > 1){
                    final data = await RepositoryMovieData(param.client)
                        .fetchListMovieData(
                            param.type, param.categories, currentListSize + 1);
                  return data.results;
                  }
                  return (snapshot.data as ListMovieData).results;
                },
              );
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

class _MainListItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListItemView();
}
