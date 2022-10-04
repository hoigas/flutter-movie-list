import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/error_count/error_count_bloc.dart';
import 'blocs/movie_list_status.dart';
import 'blocs/now_playing_movie/now_playing_movie_list_bloc.dart';
import 'blocs/popular/popular_movie_list_bloc.dart';
import 'blocs/upcoming/upcoming_movie_list_bloc.dart';
import 'component/card_list_widget.dart';
import 'component/page_card_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int errorCount = 2;

  @override
  void initState() {
    super.initState();

    context.read<NowPlayingMovieListBloc>().add(GetNowPlayingMovieListEvent());
    context.read<PopularMovieListBloc>().add(GetPopularMovieListEvent());
    context.read<UpcomingMovieListBloc>().add(GetUpcomingMovieListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(),
      bottomNavigationBar: buildBottom(),
    );
  }

  Widget buildBody() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: BlocBuilder<ErrorCountBloc, ErrorCountState>(
        builder: (context, state) {
          return (state.errorCount == 2)
              ? Center(
                  child: Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    BlocBuilder<NowPlayingMovieListBloc, NowPlayingMovieListState>(
                      builder: (context, state) {
                        if (state.status == MovieListStatus.initial) {
                          return const SizedBox(height: 340);
                        }

                        if (state.status == MovieListStatus.error) {
                          context.read<ErrorCountBloc>().add(IncreaseErrorCountEvent());
                        }

                        if (state.status == MovieListStatus.loading) {
                          return const SizedBox(
                            height: 340,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return PageCardListWidget(movies: state.movies);
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<PopularMovieListBloc, PopularMovieListState>(
                      builder: (context, state) {
                        if (state.status == MovieListStatus.initial) {
                          return const SizedBox(height: 260);
                        }

                        if (state.status == MovieListStatus.error) {
                          context.read<ErrorCountBloc>().add(IncreaseErrorCountEvent());
                        }

                        if (state.status == MovieListStatus.loading) {
                          return const SizedBox(
                            height: 260,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return CardListWidget(movies: state.movies, title: 'Popular');
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<UpcomingMovieListBloc, UpcomingMovieListState>(
                      builder: (context, state) {
                        if (state.status == MovieListStatus.initial) {
                          return const SizedBox(height: 260);
                        }

                        if (state.status == MovieListStatus.error) {
                          context.read<ErrorCountBloc>().add(IncreaseErrorCountEvent());
                        }

                        if (state.status == MovieListStatus.loading) {
                          return const SizedBox(
                            height: 260,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return CardListWidget(movies: state.movies, title: 'Upcoming');
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget buildBottom() {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
