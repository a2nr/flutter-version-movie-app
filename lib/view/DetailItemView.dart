import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageLoader {
  final String _url;
  final Completer<ImageProvider> completer = Completer<ImageProvider>();
  ImageLoader(this._url);

  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _url,
      imageBuilder: (c, i) {
        completer.complete(i);
        return CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            );
      },
      placeholder: (c, s) => CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColorLight,
          ),
      errorWidget: (c, s, o) {
        completer.completeError(o);
        return CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            );
      },
    );
  }
}

class _MainDetailView extends State<MainDetailView> {
  final MovieData data;
  double paddingBottom=0;
  double expanded=0;
  double expandedHeight=0;
  ImageLoader imageLoader;
  Widget loaderWidget = Image(
    image: Image.memory(kTransparentImage).image,
    fit: BoxFit.fitWidth,
  );

  _MainDetailView(this.data) {
    imageLoader =
        ImageLoader(RepositoryMovieData.getImageLink("w500", data.posterPath));
  }

  @override
  void initState() {
    super.initState();
    expandedHeight = 2 * kToolbarHeight;
    paddingBottom = 0;
    expanded = 0;
    imageLoader.completer.future.then((ImageProvider image) {
      setState(() {
        paddingBottom = (kToolbarHeight * 5);
        expanded =kToolbarHeight + 2;
        loaderWidget = Image(
          image: image,
          fit: BoxFit.fitWidth,
        );
      });
    },
    onError: (o,s){
      print("$o:$s");
      setState(() {
      expandedHeight = 0;
      expanded=0;
      });
    });
    loaderWidget = Center(
      child: Center(child: imageLoader.build(context)),
    );
  }

  Widget build(BuildContext context) {
    if (expanded != 0) {
      expandedHeight = (1.5 * MediaQuery.of(context).size.width);
    }

    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          title: Text(
            data.title,
            overflow: TextOverflow.fade,
            key: Key("main_title"),
          ),
          pinned: true,
          floating: false,
          snap: false,
          expandedHeight:  expandedHeight + expanded,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              icon: Icon(Icons.favorite,
                  color: Theme.of(context).primaryColorLight),
              onPressed: () {
                print("favorite clicked!!");
              },
            )
          ],
          leading: IconButton(
            onPressed: () {
              print("Back clicked!");
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
              background: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: kToolbarHeight + 10),
              loaderWidget
            ],
          ))),
      SliverToBoxAdapter(
          child: Container(
        padding: EdgeInsets.only(top: kToolbarHeight, bottom: expandedHeight - paddingBottom),
        child: Table(
          children: [
            _tableRow("Vote Average:  ", data.voteAverage.toString()),
            _tableRow("Popularity:  ", data.popularity.toString()),
            _tableRow("Title:  ", data.title),
            _tableRow("Overview:  ", data.overview, height: kToolbarHeight * 2),
            _tableRow("Original Title:  ", data.originalTitle),
            _tableRow("Original Languages:  ", data.originalLanguage),
            _tableRow("Spoken Languages:  ", data.spokenLanguages[0].name),
          ],
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {1: FractionColumnWidth(.8)},
        ),
      )),
    ]);
  }

  TableRow _tableRow(String indikator, String keterangan,
          {double height = kToolbarHeight / 2}) =>
      TableRow(children: [
        Container(
            padding: EdgeInsets.only(right: 8),
            height: height,
            child: Text(
              indikator,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.caption,
            )),
        Container(
            height: height,
            child: Text(
              keterangan,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.caption,
            )),
      ]);
}

class MainDetailView extends StatefulWidget {
  final MovieData _data;
  MainDetailView(this._data);
  @override
  State<StatefulWidget> createState() {
    return _MainDetailView(_data);
  }
}

class _DetailItemView extends State<DetailItemView> {
  final client;
  final type;
  final id;

  _DetailItemView(this.type, this.id, this.client);
  Widget _loadingWidget(
    BuildContext context,
    String state,
  ) {
    var msg = "";
    Widget flexSpace;
    switch (state) {
      case "error":
        msg = "Check your connection !";
        flexSpace = Icon(
          Icons.broken_image,
          color: Theme.of(context).primaryColorLight,
        );
        break;
      default:
        msg = "Loading...";
        flexSpace = CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColorLight,
        );
        break;
    }
    return NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace:
                FlexibleSpaceBar(background: Center(child: flexSpace)),
          )
        ];
      },
      body: Center(
        child: Text(msg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: FutureBuilder(
              future: RepositoryMovieData(client).fetchMovieData(type, id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      MovieData data = snapshot.data;
                      print("FutureBuilder Get data: $data");
                      // return _loadImageWidget(context, data);
                      return MainDetailView(data);
                    }
                    continue def;
                  def:
                  case ConnectionState.none:
                    return _loadingWidget(context, "error");
                  default:
                    return _loadingWidget(context, "");
                }
                return _loadingWidget(context, "error");
              }),
        ));
  }
}

class DetailItemView extends StatefulWidget {
  final client;
  final type;
  final id;
  DetailItemView(this.type, this.id, this.client);
  @override
  State<StatefulWidget> createState() =>
      _DetailItemView(this.type, this.id, this.client);
}
