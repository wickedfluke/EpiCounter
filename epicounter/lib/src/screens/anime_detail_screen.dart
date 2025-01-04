import 'package:flutter/material.dart';
import './../models/anime.dart';
import './../providers/anime_provider.dart';
import 'package:provider/provider.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;
  final int index;

  AnimeDetailScreen({required this.anime, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(anime.imageUrl),
            Text(anime.title, style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 10),
            Text('Total Episodes: ${anime.totalEpisodes}', style: TextStyle(color: Colors.white)),
            Text('Watched Episodes: ${anime.watchedEpisodes}', style: TextStyle(color: Colors.white)),
            Text('Remaining Episodes: ${anime.remainingEpisodes}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic to update the anime details
                  },
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AnimeProvider>(context, listen: false).removeAnime(index);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
