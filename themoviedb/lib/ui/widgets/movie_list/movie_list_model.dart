import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  final _dateFormat = DateFormat.yMMMMd();

  List<Movie> get movies => List.unmodifiable(_movies);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> loadMovies() async {
    final moviesResponse = await _apiClient.popularMovies(1, 'ru-RU');
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }
}
