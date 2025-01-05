class Manga {
  String title;
  int totalVolumes;
  int totalChapters;
  int readVolumes;
  int readChapters;
  String imageUrl;

  Manga({
    required this.title,
    required this.totalVolumes,
    required this.totalChapters,
    required this.readVolumes,
    required this.readChapters,
    required this.imageUrl,
  });

  // Calcola il numero di volumi e capitoli rimanenti
  int get remainingVolumes => totalVolumes - readVolumes;
  int get remainingChapters => totalChapters - readChapters;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'totalVolumes': totalVolumes,
      'readVolumes': readVolumes,
      'remainingVolumes': remainingVolumes,
      'totalChapters': totalChapters,
      'readChapters': readChapters,
      'remainingChapters': remainingChapters,
    };
  }

  // Metodo fromJson (opzionale, per deserializzare)
  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      title: json['title'],
      imageUrl: json['imageUrl'],
      totalVolumes: json['totalVolumes'],
      readVolumes: json['readVolumes'],
      totalChapters: json['totalChapters'],
      readChapters: json['readChapters'],
    );
  }
}
