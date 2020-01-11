import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/repository/MovieData.dart';
import 'package:movie_app/repository/RepositoryMovieData.dart';

class _ItemView {
  final MovieData _data;
  _ItemView(this._data);

  Widget _imageBackdrop(String _imagePath) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        child: CachedNetworkImage(
          imageUrl: RepositoryMovieData.getImageLink("w500", _imagePath),
          placeholder: (context, url) => Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: CircularProgressIndicator()))),
          errorWidget: (context, url, error) => Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Icon(Icons.broken_image)))),
        ));
  }

  Widget _firstRowTextItem(
      double _averageVote, String _title, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Row(children: <Widget>[
        SvgPicture.asset(
          'asset/ic_stars_24px.svg',
          color: Theme.of(context).primaryColor,
        ),
        Text("$_averageVote",
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Theme.of(context).primaryColor)),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            // "Judul ini dipersembahkan untuk judul yang jancok sekali",
            "$_title",
            style: Theme.of(context).textTheme.headline,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            key: Key("title_movie"),
          ),
        )
      ]),
    );
  }

  Widget _secondRowTextItem(
      String _language, String _releaseData, BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 8),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Language: $_language",
                  style: Theme.of(context).textTheme.caption),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Release Date: $_releaseData",
                  style: Theme.of(context).textTheme.caption),
            )),
          ],
        ));
  }

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
            constraints: BoxConstraints.tightFor(height: 330, width: 500),
            child: Card(
              margin: EdgeInsets.all(16),
              elevation: 5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _imageBackdrop(_data.backdropPath),
                    _firstRowTextItem(_data.voteAverage, _data.title, context),
                    _secondRowTextItem(
                        _data.originalLanguage, _data.releaseDate, context)
                  ]),
            )));
  }
}

class ItemView extends StatelessWidget {
  final data;
  ItemView(this.data);
  @override
  Widget build(BuildContext context) => _ItemView(this.data).build(context);
}
