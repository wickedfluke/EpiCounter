import 'package:flutter/material.dart';
import './../models/manga.dart';

class MangaProvider with ChangeNotifier {
  List<Manga> _mangaList = [];

  List<Manga> get mangaList => _mangaList;

  void addManga(Manga manga) {
    _mangaList.add(manga);
    notifyListeners();
  }

  void updateManga(int index, Manga updatedManga) {
    _mangaList[index] = updatedManga;
    notifyListeners();
  }

  void removeManga(int index) {
    _mangaList.removeAt(index);
    notifyListeners();
  }
}
