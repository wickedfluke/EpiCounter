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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    manga.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                manga.title,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Volumi
              Text(
                'Total Volumes: ${manga.totalVolumes}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (manga.readVolumes > 0) {
                        Provider.of<MangaProvider>(context, listen: false)
                            .updateReadVolumes(index, manga.readVolumes - 1);
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    'Read Volumes: ${manga.readVolumes}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      if (manga.readVolumes < manga.totalVolumes) {
                        Provider.of<MangaProvider>(context, listen: false)
                            .updateReadVolumes(index, manga.readVolumes + 1);
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Text(
                'Remaining Volumes: ${manga.remainingVolumes}',
                style: TextStyle(color: Colors.yellow[700], fontSize: 16),
              ),
              SizedBox(height: 20),
              // Capitoli
              Text(
                'Total Chapters: ${manga.totalChapters}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (manga.readChapters > 0) {
                        Provider.of<MangaProvider>(context, listen: false)
                            .updateReadChapters(index, manga.readChapters - 1);
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    'Read Chapters: ${manga.readChapters}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      if (manga.readChapters < manga.totalChapters) {
                        Provider.of<MangaProvider>(context, listen: false)
                            .updateReadChapters(index, manga.readChapters + 1);
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Text(
                'Remaining Chapters: ${manga.remainingChapters}',
                style: TextStyle(color: Colors.yellow[700], fontSize: 16),
              ),
              SizedBox(height: 30),
              // Pulsanti Edit e Delete
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
