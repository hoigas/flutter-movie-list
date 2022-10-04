import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/blocs/movie_list_status.dart';
import '../blocks/movie_detail_bloc.dart';

class MovieContents extends StatefulWidget {
  final int id;

  const MovieContents({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<MovieContents> createState() => _MovieContentsState();
}

class _MovieContentsState extends State<MovieContents> {
  @override
  void initState() {
    super.initState();

    context.read<MovieDetailBloc>().add(GetMovieEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state.status == MovieListStatus.initial) {
          return Container(
            color: Colors.black,
          );
        }

        if (state.status == MovieListStatus.error) {
          return Container(
            color: Colors.black,
          );
        }

        if (state.status == MovieListStatus.loading) {
          return Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              state.movie.backdropPath == ''
                  ? Container(
                      height: 200,
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _showImage(context, 'https://image.tmdb.org/t/p/w500/${state.movie.backdropPath}'),
              SizedBox(height: 45),
              Text(
                state.movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 15.0,
                  ),
                  SizedBox(width: 3),
                  Text(
                    state.movie.voteAverage.toString() ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    state.movie.releaseDate ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                state.movie.overview ?? "",
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _showImage(context, image) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Image.network(
        image,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
