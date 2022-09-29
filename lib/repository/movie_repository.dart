import 'dart:convert';

import 'package:flutter_movie_list/repository/api/ApiProvider.dart';

import '../model/movie_list.dart';

class MovieRepository {
  final ApiProvider _provider;

  MovieRepository({
    required ApiProvider provider,
  }) : _provider = provider;

  Future<MovieList> getList() async {
    final response = await _provider.get(
      path: 'movie/now_playing',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }
}
