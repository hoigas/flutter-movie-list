import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/repository/api/ApiProvider.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MovieRepository _repository;
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();

    _repository = MovieRepository(provider: ApiProvider());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo Home Page"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final movie = _movies[index];

          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
                title: Text(movie.title),
                subtitle: Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text('평점 : '),
                    Container(
                      child: Text(movie.voteAverage.toString()),
                    ),
                    Spacer(),
                    Text('개봉일 : '),
                    Container(
                      child: Text(movie.releaseDate),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: _movies.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _repository.getList().then((response) {
            setState(() {
              _movies = response.results;
              print("movies : ${_movies[1]}");
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
