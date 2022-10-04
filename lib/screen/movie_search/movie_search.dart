import 'package:flutter/material.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({Key? key}) : super(key: key);

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Movie Search'),
      ),
    );
  }
}
