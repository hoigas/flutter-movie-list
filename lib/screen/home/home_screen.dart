import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';

import 'component/card_list_widget.dart';
import 'component/page_card_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieRepository _repository;
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _upcomingMovies = [];

  @override
  void initState() {
    super.initState();

    _repository = MovieRepository(provider: ApiProvider());
    _repository.getNowPlayingList().then((response) {
      setState(() {
        _nowPlayingMovies = response.results;
      });
    });
    _repository.getPopularList().then((response) {
      setState(() {
        _popularMovies = response.results;
      });
    });
    _repository.getUpcomingList().then((response) {
      setState(() {
        _upcomingMovies = response.results;
      });
    });
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
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          PageCardListWidget(movies: _nowPlayingMovies),
          const SizedBox(height: 20),
          CardListWidget(movies: _popularMovies, title: 'Popular'),
          const SizedBox(height: 30),
          CardListWidget(movies: _upcomingMovies, title: 'Upcoming'),
        ],
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
