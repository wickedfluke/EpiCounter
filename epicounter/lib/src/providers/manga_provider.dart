import 'package:flutter/material.dart';
import './../models/manga.dart';
import './../services/storage_service.dart';  // Importa il servizio di archiviazione

class MangaProvider with ChangeNotifier {
  List<Manga> _mangaList = [];

  List<Manga> get mangaList => _mangaList;

  // Costruttore per caricare i manga all'avvio
  MangaProvider() {
    loadManga();
  }

  // Carica la lista dei manga dal servizio di archiviazione
  Future<void> loadManga() async {
    _mangaList = await StorageService.loadManga();  // Usa il metodo che carica i manga
    notifyListeners();
  }

  // Aggiungi un nuovo manga
  Future<void> addManga(Manga manga) async {
    _mangaList.add(manga);
    await StorageService.saveManga(_mangaList);  // Salva i manga dopo aver aggiunto uno nuovo
    notifyListeners();
  }

  // Rimuovi un manga
  Future<void> removeManga(int index) async {
    _mangaList.removeAt(index);
    await StorageService.saveManga(_mangaList);  // Salva i manga dopo la rimozione
    notifyListeners();
  }

  // Aggiorna il numero di volumi letti
  Future<void> updateReadVolumes(int index, int newCount) async {
    _mangaList[index].readVolumes = newCount;
    await StorageService.saveManga(_mangaList);  // Salva i manga dopo l'aggiornamento
    notifyListeners();
  }

  // Aggiorna il numero di capitoli letti
  Future<void> updateReadChapters(int index, int newCount) async {
    _mangaList[index].readChapters = newCount;
    await StorageService.saveManga(_mangaList);  // Salva i manga dopo l'aggiornamento
    notifyListeners();
  }
}
