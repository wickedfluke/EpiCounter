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
}
