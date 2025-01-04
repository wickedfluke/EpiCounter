class Arc {
  String name;
  int episodesWatched;
  int totalEpisodes;

  Arc({required this.name, required this.episodesWatched, required this.totalEpisodes});
}

class Anime {
  String title;
  String imageUrl;
  int episodesWatched;
  int totalEpisodes;
  List<Arc>? arcs; // opzionale

  Anime({
    required this.title,
    required this.imageUrl,
    required this.episodesWatched,
    required this.totalEpisodes,
    this.arcs,
  });
}
