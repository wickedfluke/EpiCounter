import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './../models/anime.dart';
import './../models/manga.dart';

class StorageService {
  static Future<void> saveAnime(List<Anime> animeList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> animeJson = animeList.map((anime) => json.encode(anime.toJson())).toList();
    await prefs.setStringList('animeList', animeJson);
  }

  static Future<List<Anime>> loadAnime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? animeJson = prefs.getStringList('animeList');
    if (animeJson != null) {
      return animeJson.map((anime) => Anime.fromJson(json.decode(anime))).toList();
    }
    return [];
  }

  static Future<void> saveManga(List<Manga> mangaList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mangaJson = mangaList.map((manga) => json.encode(manga.toJson())).toList();
    await prefs.setStringList('mangaList', mangaJson);
  }

  static Future<List<Manga>> loadManga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? mangaJson = prefs.getStringList('mangaList');
    if (mangaJson != null) {
      return mangaJson.map((manga) => Manga.fromJson(json.decode(manga))).toList();
    }
    return [];
  }
}
