import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/repository/ListMovieData.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:movie_app/view/DetailItemView.dart';
import 'package:movie_app/view/ItemView.dart';
import 'package:pagination_view/pagination_view.dart';

class ListItemViewFactory {
  static Widget widget({
    @required type,
    @required categories,
    @required client,
    isSliver = false,
  }) =>
      _InheritageListItemView(
        categories: categories,
        client: client,
        type: type,
        child: _MainListItemView(
          isSliver: isSliver,
        ),
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
                    onClickCallback: (thisData) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailItemView(
                                param.type, thisData.id, param.client)),
                      );
                    },
                  );
                },
                onEmpty: Center(
                  child: Icon(Icons.error_outline),
                ),
                pageFetch: (int currentListSize) async {
                  if (currentListSize > 1) {
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

class _SliverListItemView extends State<_MainListItemView> {
  int _page = 1;
  bool _isNeedLoading = true;
  List<MovieData> _cacheMovieData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cacheMovieData != null)
      setState(() {
        print("depdancies change");
        _isNeedLoading = true;
        _cacheMovieData.removeRange(0, _cacheMovieData.length);
        _page = 1;
      });
  }

  @override
  Widget build(BuildContext context) {
    final _param = _InheritageListItemView.of(context);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait ;
    print("curent page: $_page");
    return FutureBuilder(
      future: RepositoryMovieData(_param.client)
          .fetchListMovieData(_param.type, _param.categories, _page),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (_cacheMovieData == null)
              _cacheMovieData = (snapshot.data as ListMovieData).results;
            else
              _cacheMovieData.addAll((snapshot.data as ListMovieData).results);
            _isNeedLoading = false;
            break;
          default:
            _isNeedLoading = true;
            break;
        }
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              if (_cacheMovieData != null) {
                if ((i > (_cacheMovieData.length - 1)) && (_isNeedLoading))
                  return ItemView.holder(context);
                if (((i + 5) > (_cacheMovieData.length)) && (!_isNeedLoading))
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _isNeedLoading = true;
                      _page++;
                    });
                  });
                print("index: $i");
                return ItemView(
                  _cacheMovieData[i],
                  onClickCallback: (data) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailItemView(
                              _param.type, data.id, _param.client)),
                    );
                  },
                );
              } else
                return ItemView.holder(context);
            },
            childCount: _isNeedLoading ? null : _cacheMovieData.length,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: isPortrait ? 1 : 2),
        );
      },
    );
  }
}

class _MainListItemView extends StatefulWidget {
  final bool isSliver;

  _MainListItemView({this.isSliver});

  @override
  State<StatefulWidget> createState() {
    if (isSliver) return _SliverListItemView();
    return _ListItemView();
  }
}
