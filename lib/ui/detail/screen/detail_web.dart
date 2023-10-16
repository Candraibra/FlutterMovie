import 'package:flutter/material.dart';

import '../../../model/movieList.dart';
import '../../widget/favorite_button.dart';

class DetailWebPage extends StatefulWidget {
  final Movie movie;

  const DetailWebPage({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() {
    return _DetailMobileState();
  }
}

class _DetailMobileState extends State<DetailWebPage> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.movie.fullBackDropPath,
                width: 200, // Adjust the width as needed
              ),
              SizedBox(height: 16),
              Text(
                widget.movie.title,
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(
                "Release Date: ${widget.movie.releaseDate}",
                style: textTheme.bodyMedium,
              ),
              SizedBox(height: 8),
              Text(
                "Overview:",
                style: textTheme.titleLarge,
              ),
              Text(
                widget.movie.overview,
                style: textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(
                    widget.movie.voteAverage.toString(),
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "(${widget.movie.voteCount} votes)",
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
