import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';

class CardListWidget extends StatefulWidget {
  final List<Movie> movies;
  final String title;

  const CardListWidget({required this.movies, required this.title, Key? key}) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemCount: widget.movies.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              return _buildCard(widget.movies[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Movie movie) {
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
