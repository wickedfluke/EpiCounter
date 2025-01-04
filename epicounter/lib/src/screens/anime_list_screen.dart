import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/anime_provider.dart';
import 'anime_detail_screen.dart';
import './../models/anime.dart';
import 'anime_add_screen.dart'; // Importiamo la schermata di aggiunta

class AnimeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List'),
        backgroundColor: Colors.black87,
      ),
      body: Consumer<AnimeProvider>(
        builder: (context, animeProvider, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: animeProvider.animeList.length,
            itemBuilder: (context, index) {
              Anime anime = animeProvider.animeList[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimeDetailScreen(anime: anime, index: index),
                  ),
                ),
                child: Card(
                  color: Colors.grey[850],
                  child: Column(
                    children: [
                      Image.network(anime.imageUrl, fit: BoxFit.cover),
                      Text(anime.title, style: TextStyle(color: Colors.white)),
                      Text('${anime.watchedEpisodes}/${anime.totalEpisodes} episodes', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviga alla schermata di aggiunta anime
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimeAddScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }
}