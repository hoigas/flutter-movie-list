import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/screen/movie_detail/movie_detail.dart';

import '../../../main.dart';

class PageCardListWidget extends StatefulWidget {
  final List<Movie> movies;

  const PageCardListWidget({required this.movies, Key? key}) : super(key: key);

  @override
  State<PageCardListWidget> createState() => _PageCardListWidgetState();
}

class _PageCardListWidgetState extends State<PageCardListWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) {
              return _buildCard(widget.movies[index]);
            },
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          _buildPoint(widget.movies.length),
        ],
      ),
    );
  }

  Widget _buildCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, movieDetailRoute, arguments: movie.id);
      },
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(int length) {
    return Positioned(
      left: 10,
      bottom: 8,
      child: Row(
        children: List.generate(
          length,
          (index) => Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: (currentIndex == index) ? Colors.white.withOpacity(0.6) : Colors.grey.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 3),
            ],
          ),
        ),
      ),
    );
  }
}
