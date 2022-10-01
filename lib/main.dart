import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/error_count/error_count_bloc.dart';
import 'package:flutter_movie_list/screen/home/blocs/now_playing_movie/now_playing_movie_list_bloc.dart';
import 'package:flutter_movie_list/screen/home/blocs/popular/popular_movie_list_bloc.dart';
import 'package:flutter_movie_list/screen/home/blocs/upcoming/upcoming_movie_list_bloc.dart';
import 'package:flutter_movie_list/screen/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RepositoryProvider(
        create: (context) => MovieRepository(provider: ApiProvider()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ErrorCountBloc>(
              create: (context) => ErrorCountBloc(),
            ),
            BlocProvider<NowPlayingMovieListBloc>(
              create: (context) => NowPlayingMovieListBloc(
                movieRepository: context.read<MovieRepository>(),
              ),
            ),
            BlocProvider<PopularMovieListBloc>(
              create: (context) => PopularMovieListBloc(
                movieRepository: context.read<MovieRepository>(),
              ),
            ),
            BlocProvider<UpcomingMovieListBloc>(
              create: (context) => UpcomingMovieListBloc(
                movieRepository: context.read<MovieRepository>(),
              ),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
