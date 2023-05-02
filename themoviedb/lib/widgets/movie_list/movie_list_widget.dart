import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.moviePlaceholder,
      title: 'Джон Уик 3',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 2,
      imageName: AppImages.moviePlaceholder,
      title: 'Оружейный барон',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 3,
      imageName: AppImages.moviePlaceholder,
      title: 'Достучаться до небес',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 4,
      imageName: AppImages.moviePlaceholder,
      title: 'Бойцовский клуб',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 5,
      imageName: AppImages.moviePlaceholder,
      title: 'Настоящий детектив',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 6,
      imageName: AppImages.moviePlaceholder,
      title: 'Джентельмены',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 7,
      imageName: AppImages.moviePlaceholder,
      title: 'Криминальное чтиво',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 8,
      imageName: AppImages.moviePlaceholder,
      title: 'Человек дождя',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 9,
      imageName: AppImages.moviePlaceholder,
      title: 'Форрест Гамп',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
    Movie(
      id: 10,
      imageName: AppImages.moviePlaceholder,
      title: 'Зеленая книга',
      time: 'May 16, 2019',
      description:
          'Киллер-изгой бежит от байкеров-самураев и других неприятностей.',
    ),
  ];

  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      '/main_screen/movie_details',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 66),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (context, index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                            movie.imageName,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                movie.time,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
