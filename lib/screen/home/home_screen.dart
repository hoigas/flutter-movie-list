import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';

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
  int currentIndex = 0;

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

  Widget buildPageCardList(List<Movie> movies) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500/${movies[index].backdropPath}',
                      fit: BoxFit.fitHeight,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Text(
                            movies[index].title,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: movies.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Positioned(
            left: 10,
            bottom: 8,
            child: Row(
              children: List.generate(
                movies.length,
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
                    SizedBox(width: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardList(List<Movie> movies, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemCount: movies.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              return buildCard(movies[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCard(Movie movie) {
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
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          buildPageCardList(_nowPlayingMovies),
          const SizedBox(height: 20),
          buildCardList(_popularMovies, 'Popular'),
          const SizedBox(height: 30),
          buildCardList(_upcomingMovies, 'Upcoming'),
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
