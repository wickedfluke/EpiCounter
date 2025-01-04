import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import '../models/anime.dart';
import 'anime_detail_screen.dart';

class AnimeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("EpiCounter"),
        backgroundColor: const Color(0xFF2C2C2C), // Sfondo grigio scuro
      ),
      backgroundColor: const Color(0xFF2C2C2C), // Sfondo grigio scuro
      body: animeProvider.animes.isEmpty
          ? const Center(
              child: Text(
                "Nessun Anime Aggiunto",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Due anime per riga
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2 / 3, // Rettangolo verticale
              ),
              itemCount: animeProvider.animes.length,
              itemBuilder: (context, index) {
                final anime = animeProvider.animes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailScreen(anime: anime),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF404040), // Grigio scuro
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 3, // Rettangolo verticale
                          child: Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            anime.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "Episodi: ${anime.episodesWatched}/${anime.totalEpisodes}",
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "Da vedere: ${anime.episodesWatched + 1}",
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "Rimanenti: ${anime.totalEpisodes - anime.episodesWatched}",
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE7B916), // Giallo scuro
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          _showAddAnimeDialog(context);
        },
      ),
    );
  }

  void _showAddAnimeDialog(BuildContext context) {
    final titleController = TextEditingController();
    final imageUrlController = TextEditingController();
    final episodesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Aggiungi Anime"),
          backgroundColor: const Color(0xFF404040), // Sfondo grigio scuro
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Titolo",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE7B916)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: "URL Immagine",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE7B916)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: episodesController,
                decoration: const InputDecoration(
                  labelText: "Episodi Totali",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE7B916)),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il dialog
              },
              child: const Text(
                "Annulla",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE7B916)),
              onPressed: () {
                final title = titleController.text;
                final imageUrl = imageUrlController.text;
                final totalEpisodes = int.tryParse(episodesController.text) ?? 0;

                if (title.isNotEmpty && imageUrl.isNotEmpty && totalEpisodes > 0) {
                  Provider.of<AnimeProvider>(context, listen: false).addAnime(
                    Anime(
                      title: title,
                      imageUrl: imageUrl,
                      episodesWatched: 0,
                      totalEpisodes: totalEpisodes,
                    ),
                  );
                }
                Navigator.of(context).pop(); // Chiudi il dialog
              },
              child: const Text(
                "Aggiungi",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
