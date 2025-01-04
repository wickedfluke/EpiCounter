import 'package:flutter/material.dart';
import './../models/anime.dart';
import './../providers/anime_provider.dart';
import 'package:provider/provider.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Anime anime;
  final int index;

  AnimeDetailScreen({required this.anime, required this.index});

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  late int watchedEpisodes;

  @override
  void initState() {
    super.initState();
    watchedEpisodes = widget.anime.watchedEpisodes;
  }

  void updateWatchedEpisodes(int newValue) {
    setState(() {
      watchedEpisodes = newValue;
    });
    Provider.of<AnimeProvider>(context, listen: false)
        .updateWatchedEpisodes(widget.index, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anime.title),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Immagine
              Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.anime.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.anime.title,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Total Episodes: ${widget.anime.totalEpisodes}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (watchedEpisodes > 0) {
                        updateWatchedEpisodes(watchedEpisodes - 1);
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    'Watched Episodes: $watchedEpisodes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      if (watchedEpisodes < widget.anime.totalEpisodes) {
                        updateWatchedEpisodes(watchedEpisodes + 1);
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Text(
                'Remaining Episodes: ${widget.anime.totalEpisodes - watchedEpisodes}',
                style: TextStyle(color: Colors.yellow[700], fontSize: 16),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Provider.of<AnimeProvider>(context, listen: false)
                          .removeAnime(widget.index);
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
      ),
    );
  }
}
