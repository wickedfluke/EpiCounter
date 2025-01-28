import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/anime_provider.dart';
import './../models/anime.dart';
import './anime_add_screen.dart';

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
          return ReorderableListView.builder(
            itemCount: animeProvider.animeList.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              animeProvider.reorderAnimeList(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              Anime anime = animeProvider.animeList[index];
              int remainingEpisodes = anime.remainingEpisodes;

              return GestureDetector(
                key: ValueKey(anime), // Key necessaria per l'ordine
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => AnimeEditModal(
                      anime: anime,
                      index: index,
                      provider: animeProvider,
                    ),
                  );
                },
                child: Card(
                  color: Colors.grey[850],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Icona di trascinamento (a sinistra)
                        ReorderableDragStartListener(
                          index: index,
                          child: Icon(
                            Icons.drag_handle,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(width: 8),
                        // Immagine dell'anime
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(right: 8.0),
                          child: Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Dettagli dell'anime
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                anime.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${anime.watchedEpisodes}/${anime.totalEpisodes} episodes watched',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                'Next: episode $remainingEpisodes',
                                style: TextStyle(color: Colors.yellow[700], fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Pulsanti per modificare gli episodi visti
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (anime.watchedEpisodes > 0) {
                                  animeProvider.updateWatchedEpisodes(
                                    index,
                                    anime.watchedEpisodes - 1,
                                  );
                                }
                              },
                              icon: Icon(Icons.remove, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                if (anime.watchedEpisodes < anime.totalEpisodes) {
                                  animeProvider.updateWatchedEpisodes(
                                    index,
                                    anime.watchedEpisodes + 1,
                                  );
                                }
                              },
                              icon: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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

class AnimeEditModal extends StatefulWidget {
  final Anime anime;
  final int index;
  final AnimeProvider provider;

  AnimeEditModal({required this.anime, required this.index, required this.provider});

  @override
  _AnimeEditModalState createState() => _AnimeEditModalState();
}

class _AnimeEditModalState extends State<AnimeEditModal> {
  late TextEditingController _titleController;
  late TextEditingController _totalEpisodesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.anime.title);
    _totalEpisodesController =
        TextEditingController(text: widget.anime.totalEpisodes.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _totalEpisodesController,
            decoration: InputDecoration(labelText: 'Total Episodes'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final updatedAnime = Anime(
                title: _titleController.text,
                totalEpisodes: int.tryParse(_totalEpisodesController.text) ?? widget.anime.totalEpisodes,
                watchedEpisodes: widget.anime.watchedEpisodes,
                imageUrl: widget.anime.imageUrl,
              );
              widget.provider.removeAnime(widget.index);
              widget.provider.addAnime(updatedAnime);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              widget.provider.removeAnime(widget.index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
