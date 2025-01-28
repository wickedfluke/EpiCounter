import 'package:flutter/material.dart';
import './../models/anime.dart';
import './../services/storage_service.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _animeList = [];

  List<Anime> get animeList => _animeList;

  AnimeProvider() {
    loadAnime();
  }

  Future<void> loadAnime() async {
    _animeList = await StorageService.loadAnime();
    notifyListeners();
  }

  Future<void> addAnime(Anime anime) async {
    _animeList.add(anime);
    await StorageService.saveAnime(_animeList);
    notifyListeners();
  }

  Future<void> removeAnime(int index) async {
    _animeList.removeAt(index);
    await StorageService.saveAnime(_animeList);
    notifyListeners();
  }

  Future<void> updateWatchedEpisodes(int index, int newWatchedEpisodes) async {
    _animeList[index].watchedEpisodes = newWatchedEpisodes;
    await StorageService.saveAnime(_animeList);
    notifyListeners();
  }

  Future<void> reorderAnimeList(int oldIndex, int newIndex) async{
    final Anime anime = animeList.removeAt(oldIndex);
    animeList.insert(newIndex, anime);
    await StorageService.saveAnime(_animeList);
    notifyListeners();
  }
}
