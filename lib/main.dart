import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/repository/util/ConstMovie.dart';
import 'package:movie_app/view/ListItemView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Belajar Flutter',
        home: Center(
            child: Scaffold(
          appBar: AppBar(
            title: const Text('Belajar Flutter'),
          ),
          body: ListItemView(TypeMovie.MOVIE,CategoriesMovie.TRENDING,Client())
        )));
  }
}