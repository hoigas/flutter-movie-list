import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/movie_list_status.dart';

import 'blocs/movie_search_bloc.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({Key? key}) : super(key: key);

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieSearchBloc(movieRepository: MovieRepository(provider: ApiProvider())),
      child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  TextField(
                    controller: textFieldController,
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(color: Colors.grey, Icons.search, size: 22),
                        onPressed: () {
                          context.read<MovieSearchBloc>().add(SearchMovieListEvent(search: textFieldController.text));
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel, size: 20),
                        color: Colors.grey.withOpacity(0.7),
                        onPressed: () {
                          textFieldController.clear();
                        },
                      ),
                    ),
                  ),
                  _buildSearchMovieList(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildSearchMovieList(MovieSearchState state) {
  if (state.status == MovieListStatus.initial) {
    return Expanded(
      child: Container(
        color: Colors.black,
      ),
    );
  }

  if (state.status == MovieListStatus.error) {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Text('Search Error', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  if (state.status == MovieListStatus.loading) {
    return Expanded(
        child: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
    ),
      );
  }

  return Expanded(
    child: ListView.builder(
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Text(state.movies[index].title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
        );
      },
    ),
  );
}
