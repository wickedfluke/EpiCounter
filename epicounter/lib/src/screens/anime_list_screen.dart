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
              childAspectRatio: 0.7, // Riduciamo l'aspect ratio
            ),
            itemCount: animeProvider.animeList.length,
            itemBuilder: (context, index) {
              Anime anime = animeProvider.animeList[index];
              int remainingEpisodes = anime.totalEpisodes - anime.watchedEpisodes;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Immagine con dimensioni fisse
                      Container(
                        width: double.infinity,
                        height: 180, // Altezza fissa dell'immagine
                        child: Image.network(
                          anime.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Testo sotto l'immagine
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anime.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${anime.watchedEpisodes}/${anime.totalEpisodes} episodes watched',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              '$remainingEpisodes episodes remaining',
                              style: TextStyle(color: Colors.yellow[700], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
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
