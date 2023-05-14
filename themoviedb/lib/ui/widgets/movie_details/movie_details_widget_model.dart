import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsWidgetModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  String _locale = '';
  bool _isFavorite = false;
  MovieDetails? _movieDetails;
  late DateFormat _dateFormat;

  MovieDetailsWidgetModel(this.movieId);

  MovieDetails? get movieDetails => _movieDetails;

  bool get isFavorite => _isFavorite;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();

    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }
    notifyListeners();
  }
}
