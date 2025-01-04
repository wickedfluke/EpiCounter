class Anime {
  String title;
  int totalEpisodes;
  int watchedEpisodes;
  String imageUrl;

  Anime({
    required this.title,
    required this.totalEpisodes,
    required this.watchedEpisodes,
    required this.imageUrl,
  });

  // Calcola il numero di episodi rimanenti
  int get remainingEpisodes => totalEpisodes - watchedEpisodes;
}
