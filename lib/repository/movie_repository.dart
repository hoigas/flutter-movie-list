import 'dart:convert';

import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';

import '../model/movie_list.dart';

class MovieRepository {
  final ApiProvider _provider;

  MovieRepository({
    required ApiProvider provider,
  }) : _provider = provider;

  Future<MovieList> getNowPlayingList() async {
    final response = await _provider.get(
      path: 'movie/now_playing',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieList> getPopularList() async {
    final response = await _provider.get(
      path: 'movie/popular',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieList> getUpcomingList() async {
    final response = await _provider.get(
      path: 'movie/upcoming',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await _provider.get(
      path: 'movie/$id',
      parameters: {
        'page': "1",
      },
    );
    return Movie.fromJson(jsonDecode(response));
  }
}
