import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';
import 'package:transparent_image/transparent_image.dart';

class _DetailItemView extends State<DetailItemView> {
  final client;
  final type;
  final id;

  _DetailItemView(this.type, this.id, this.client);

  Widget _loadedDataWidget(
      BuildContext context, ImageProvider image, MovieData data) {
    var expandedHeight;
    if(MediaQuery.of(context) != null){
     expandedHeight = (1.5 * MediaQuery.of(context).size.width);
    }
    else{
      expandedHeight = (1.5 * 560);
    }
    double paddingBottom;
    double expanded;
    Widget posterImage;
    if (image == null) {
      paddingBottom = 0;
      expanded = 0;
      posterImage = Image.memory(kTransparentImage);
    } else {
      paddingBottom = expandedHeight - (kToolbarHeight * 5);
      expanded = expandedHeight + kToolbarHeight + 2;
      posterImage = Image(
        image: image,
        fit: BoxFit.fitHeight,
      );
    }
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          title: Text(
            data.title,
            overflow: TextOverflow.fade,
          ),
          pinned: true,
          floating: false,
          snap: false,
          expandedHeight: expanded,
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
              posterImage,
            ],
          ))),
      SliverToBoxAdapter(
          child: Container(
        padding: EdgeInsets.only(top: kToolbarHeight, bottom: paddingBottom),
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
  Widget _loadImageWidget(BuildContext context, MovieData data) {
    Image image = Image.network(
        RepositoryMovieData.getImageLink("w500", data.posterPath));
    Completer<Image> completer = new Completer<Image>();
    image.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(image)));
    return FutureBuilder(
      future: completer.future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              final imageData = snapshot.data;
              return _loadedDataWidget(context, imageData.image, data);
            }
            continue def;
          def:
          case ConnectionState.none:{
            Image imageEmpty = Image.memory(kTransparentImage);
            return _loadedDataWidget(context, imageEmpty.image, data);
          }
          default:
            return _loadingImageWidget(context, "");
        }
        return _loadingImageWidget(context, "");
      },
    );
  }

  Widget _loadingImageWidget(BuildContext context, String state) {
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

  Widget _futureBuilder(BuildContext context) => FutureBuilder(
      future: RepositoryMovieData(client).fetchMovieData(type, id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              MovieData data = snapshot.data;
              return _loadImageWidget(context, data);
            }
            continue def;
          def:
          case ConnectionState.none:
            return _loadingImageWidget(context, "error");
          default:
            return _loadingImageWidget(context, "");
        }
      });

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: _futureBuilder(context),
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
