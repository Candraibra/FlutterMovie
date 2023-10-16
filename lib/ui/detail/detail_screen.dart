import 'package:beginner_submission/ui/detail/screen/detail_mobile.dart';
import 'package:beginner_submission/ui/detail/screen/detail_web.dart';
import 'package:flutter/material.dart';

import '../../model/movieList.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(movie: movie);
        } else {
          return DetailMobilePage(movie: movie);
        }
      },
    );
  }
}

// Stack(
// children: <Widget>[
// Positioned(
// top: 0,
// left: 0,
// right: 0,
// height: 200,
// child: Image.network(
// movie.fullBackDropPath,
// fit: BoxFit.cover,
// ),
// ),
// Positioned(
// top: 120,
// left: 16,
// height: 150,
// child: AspectRatio(
// aspectRatio: 500 / 750,
// child: ClipRRect(
// borderRadius:
// BorderRadius.all(Radius.circular(8.0)),
// child: Image.network(
// movie.fullPosterPath,
// fit: BoxFit.cover,
// ),
// ),
// ),
// ),
// ],
// ),