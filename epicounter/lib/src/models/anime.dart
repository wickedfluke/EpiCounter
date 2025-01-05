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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'totalEpisodes': totalEpisodes,
      'watchedEpisodes': watchedEpisodes,
      'remainingEpisodes': remainingEpisodes,
    };
  }

  // Metodo fromJson (opzionale, per deserializzare)
  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'],
      imageUrl: json['imageUrl'],
      totalEpisodes: json['totalEpisodes'],
      watchedEpisodes: json['watchedEpisodes'],
    );
  }

}
