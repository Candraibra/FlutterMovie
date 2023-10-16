import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

import '../../../model/movieList.dart';
import '../../widget/favorite_button.dart';

class DetailMobilePage extends StatefulWidget {
  final Movie movie;

  const DetailMobilePage({Key? key, required this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailMobileState();
  }
}

class _DetailMobileState extends State<DetailMobilePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Detail Movie",
            style: textTheme.titleMedium?.copyWith(color: Colors.white)),
        actions: [
          const FavoriteButton(),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 200,
              child: Image.network(
                widget.movie.fullBackDropPath,
                fit: BoxFit.cover,
              ).redacted(context: context, redact: isLoading)),
          Positioned(
            top: 120,
            left: 16,
            height: 150,
            child: AspectRatio(
              aspectRatio: 500 / 750,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(
                  widget.movie.fullPosterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 208,
            left: 130,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.movie.title,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                        widget.movie.voteAverage.toString() +
                            "(" +
                            widget.movie.voteCount.toString() +
                            ")",
                        style: textTheme.bodyMedium),
                    const SizedBox(width: 8),
                    Text(widget.movie.releaseDate, style: textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 280,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                Text(widget.movie.overview, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
