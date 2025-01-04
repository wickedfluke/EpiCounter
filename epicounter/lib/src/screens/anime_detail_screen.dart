import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../providers/anime_provider.dart';
import '../widgets/arc_list_tile.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailScreen({required this.anime, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);

    final updatedAnime = animeProvider.animes.firstWhere((a) => a.title == anime.title);

    return Scaffold(
      appBar: AppBar(title: Text(updatedAnime.title)),
      backgroundColor: const Color(0xFF2C2C2C),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              updatedAnime.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Episodi: ${updatedAnime.episodesWatched}/${updatedAnime.totalEpisodes}",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE7B916)),
                onPressed: () => animeProvider.updateEpisode(updatedAnime.title, 1),
                child: const Text("+1 Episodio"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE7B916)),
                onPressed: () => animeProvider.updateEpisode(updatedAnime.title, -1),
                child: const Text("-1 Episodio"),
              ),
            ],
          ),
          updatedAnime.arcs != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: updatedAnime.arcs!.length,
                    itemBuilder: (context, index) {
                      final arc = updatedAnime.arcs![index];
                      return ArcListTile(arc: arc);
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
