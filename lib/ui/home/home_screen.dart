import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redacted/redacted.dart';

import '../../model/movieList.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Movie>> _loadMovies() async {
    // Load and parse the JSON data from the asset
    final jsonString = await rootBundle.loadString('assets/movieResponse.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Check if the key "results" exists in the JSON data
    if (jsonData.containsKey("results")) {
      final List<dynamic> jsonList = jsonData["results"];
      return jsonList.map((json) => Movie.fromJson(json)).toList();
    } else {
      // Handle the case where "results" key is not present in your JSON
      return []; // Return an empty list or handle it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stream",
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                "Movie",
                style:  textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8F71),
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _loadMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final movies = snapshot.data;
            if (movies != null) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 600) {
                    return MovieGridView(gridCount: 2, movies: movies);
                  } else if (constraints.maxWidth <= 1200) {
                    return MovieGridView(gridCount: 4, movies: movies);
                  } else {
                    return MovieGridView(gridCount: 6, movies: movies);
                  }
                },
              );
            } else {
              return const Center(child: Text('Error loading data'));
            }
          }
        },
      ),
    );
  }
}

class MovieGridView extends StatefulWidget {
  final List<Movie> movies;
  final int gridCount;

  const MovieGridView({
    required this.gridCount,
    required this.movies,
  });

  @override
  _MovieGridViewState createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Watch Now',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8F71),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridCount,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 500 / 750,
            ),
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                ),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8.0)),
                          child: Image.network(
                            movie.fullPosterPath,
                            fit: BoxFit.cover,
                          ).redacted(context: context, redact: isLoading),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
