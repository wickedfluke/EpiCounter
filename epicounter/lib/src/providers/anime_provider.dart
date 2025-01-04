import 'package:flutter/material.dart';
import '../models/anime.dart';

class AnimeProvider extends ChangeNotifier {
  List<Anime> _animes = [];

  List<Anime> get animes => _animes;

  void addAnime(Anime anime) {
    _animes.add(anime);
    notifyListeners();
  }

  void updateEpisode(String title, int increment) {
    final anime = _animes.firstWhere((anime) => anime.title == title);
    anime.episodesWatched += increment;
    if (anime.episodesWatched > anime.totalEpisodes) {
      anime.episodesWatched = anime.totalEpisodes;
    } else if (anime.episodesWatched < 0) {
      anime.episodesWatched = 0;
    }
    notifyListeners();
  }
}
