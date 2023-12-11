import 'package:flutter/material.dart';
import 'package:practica_1/database/agendadb.dart';
import 'package:practica_1/models/popular_model.dart';
import 'package:practica_1/network/api_popular.dart';
import 'package:practica_1/screens/detail_movie_screen.dart';
import 'package:practica_1/widgets/item_movie_widget.dart';
// ignore: unused_import

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;
  bool showFavoritesOnly = false;
  List<PopularModel> favoriteMovies = [];

  @override
  void initState(){
    super.initState();
    apiPopular = ApiPopular();

    final db = AgendaDB();
    db.getFavoriteMovies().then((favoriteMoviesList) {
      if(showFavoritesOnly){
        favoriteMovies = favoriteMoviesList;
        print('La siguiente lista se imprime de popular_screen');
        print(favoriteMovies);
      }
    });
  }

  void _toggleFavoritesOnly(){
    setState(() {
      showFavoritesOnly = !showFavoritesOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
         actions: [
           IconButton(
             onPressed: _toggleFavoritesOnly, 
             icon: showFavoritesOnly
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border_outlined)
            )
          ],
        ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(), 
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot){
          if(snapshot.hasData){
            final moviesToShow = showFavoritesOnly
              ? snapshot.data!.where((movie) => movie.isFavorite).toList()
              : snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .9
              ),
              itemCount: moviesToShow.length,
              itemBuilder: (context, index){
                final movie = moviesToShow[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          MovieDetailScreen(movie: movie, favoriteMovies: favoriteMovies),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'moviePoster_${movie.id}',
                    //child: itemMovieWidget(movie.posterPath!),
                    child: itemMovieWidget(movie.posterPath!),
                  ),
                );
              },
            );
          }else{
            if(snapshot.hasError){
              return Center(child: Text('Algo salió mal :()'));
            }else{
              return CircularProgressIndicator();
            }
          }
        }),
    );
  }
}