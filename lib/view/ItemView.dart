import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/repository/MovieData.dart';

class _ItemView extends State<ItemView> {
  Future<MovieData> _fetcher;

  _ItemView(var id, var type, final client) {
    _fetcher = MovieData().fetchMovieData(type, id, client);
  }

  String _getImageLink(String imagePath) =>
      "https://image.tmdb.org/t/p/w500$imagePath";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetcher,
      builder: (BuildContext context, AsyncSnapshot<MovieData> snapshot) {
        if (snapshot.hasData) {
          var _data = snapshot.data;
          return Container(
            constraints: BoxConstraints.tightFor(height: 330),
            child: Card(
                margin: EdgeInsets.all(16),
                elevation: 5,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: _getImageLink(_data.pathBackdrop),
                        placeholder: (context, url) => Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                                constraints:
                                    BoxConstraints.tightFor(height: 150),
                                child: Center(
                                    child: CircularProgressIndicator()))),
                        errorWidget: (context, url, error) => Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                                constraints:
                                    BoxConstraints.tightFor(height: 150),
                                child:
                                    Center(child: Icon(Icons.broken_image)))),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              SvgPicture.asset(
                                'asset/ic_stars_24px.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                              Text("${_data.averageVote}",
                                  textDirection: TextDirection.ltr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  // "Judul ini dipersembahkan untuk judul yang jancok sekali",
                                  "${_data.title}",
                                  style: Theme.of(context).textTheme.headline,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textDirection: TextDirection.ltr,
                                ),
                              )
                            ]),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(2, 0, 2, 8),
                          child: Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text("Language: ${_data.language}",
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context).textTheme.caption),
                              )),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text(
                                    "Release Date: ${_data.releaseData}",
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context).textTheme.caption),
                              )),
                            ],
                          ))
                    ])),
          );
        } else {
          return Container(
              constraints: BoxConstraints.tightFor(height: 330),
              child: Card(
                  margin: EdgeInsets.all(16),
                  elevation: 5,
                  child: Center(child: CircularProgressIndicator())));
        }
      },
    );
  }
}

class ItemView extends StatefulWidget {
  final id, type, client;

  ItemView(this.id, this.type, this.client);

  @override
  createState() => _ItemView(this.id, this.type, this.client);
}
