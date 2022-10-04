import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/movie_detail/component/movie_contents.dart';

import 'blocks/movie_detail_bloc.dart';

class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({required this.id, Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(movieRepository: MovieRepository(provider: ApiProvider())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
        ),
        body: MovieContents(id: widget.id),
      ),
    );
  }
}
