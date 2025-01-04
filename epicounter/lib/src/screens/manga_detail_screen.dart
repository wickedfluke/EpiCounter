import 'package:flutter/material.dart';
import './../models/manga.dart';
import './../providers/manga_provider.dart';
import 'package:provider/provider.dart';

class MangaDetailScreen extends StatelessWidget {
  final Manga manga;
  final int index;

  MangaDetailScreen({required this.manga, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manga.title),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(manga.imageUrl),
            Text(manga.title, style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 10),
            Text('Total Volumes: ${manga.totalVolumes}', style: TextStyle(color: Colors.white)),
            Text('Read Volumes: ${manga.readVolumes}', style: TextStyle(color: Colors.white)),
            Text('Remaining Volumes: ${manga.remainingVolumes}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Text('Total Chapters: ${manga.totalChapters}', style: TextStyle(color: Colors.white)),
            Text('Read Chapters: ${manga.readChapters}', style: TextStyle(color: Colors.white)),
            Text('Remaining Chapters: ${manga.remainingChapters}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic to update the manga details
                  },
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<MangaProvider>(context, listen: false).removeManga(index);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
