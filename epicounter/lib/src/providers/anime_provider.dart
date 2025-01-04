import 'package:flutter/material.dart';
import './../models/anime.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _animeList = [];

  List<Anime> get animeList => _animeList;

  void addAnime(Anime anime) {
    _animeList.add(anime);
    notifyListeners();
  }

  void updateAnime(int index, Anime updatedAnime) {
    _animeList[index] = updatedAnime;
    notifyListeners();
  }

  void removeAnime(int index) {
    _animeList.removeAt(index);
    notifyListeners();
  }
}
