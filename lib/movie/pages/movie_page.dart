import 'package:flutter/material.dart';
import 'package:moviedb/movie/providers/movie_get_discover_provider.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie DB'),
      ),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.movies.isNotEmpty) {
            return ListView.builder(itemBuilder: (context, index) {
              final movie = provider.movies[index];

              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.overview),
              );
            });
          }
          return Center(
            child: Text('Not Found Discover Movies'),
          );
        },
      ),
    );
  }
}
