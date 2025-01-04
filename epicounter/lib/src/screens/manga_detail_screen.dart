import 'package:flutter/material.dart';
import './../models/manga.dart';
import './../providers/manga_provider.dart';
import 'package:provider/provider.dart';

class MangaDetailScreen extends StatefulWidget {
  final Manga manga;
  final int index;

  MangaDetailScreen({required this.manga, required this.index});

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  late int readVolumes;
  late int readChapters;

  @override
  void initState() {
    super.initState();
    readVolumes = widget.manga.readVolumes;
    readChapters = widget.manga.readChapters;
  }

  void updateReadVolumes(int newValue) {
    setState(() {
      readVolumes = newValue;
    });
    Provider.of<MangaProvider>(context, listen: false)
        .updateReadVolumes(widget.index, newValue);
  }

  void updateReadChapters(int newValue) {
    setState(() {
      readChapters = newValue;
    });
    Provider.of<MangaProvider>(context, listen: false)
        .updateReadChapters(widget.index, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.manga.title),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Immagine
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
                    widget.manga.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.manga.title,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Volumi
              Text(
                'Total Volumes: ${widget.manga.totalVolumes}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (readVolumes > 0) {
                        updateReadVolumes(readVolumes - 1);
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    'Read Volumes: $readVolumes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      if (readVolumes < widget.manga.totalVolumes) {
                        updateReadVolumes(readVolumes + 1);
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Text(
                'Remaining Volumes: ${widget.manga.totalVolumes - readVolumes}',
                style: TextStyle(color: Colors.yellow[700], fontSize: 16),
              ),
              SizedBox(height: 20),
              // Capitoli
              Text(
                'Total Chapters: ${widget.manga.totalChapters}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (readChapters > 0) {
                        updateReadChapters(readChapters - 1);
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    'Read Chapters: $readChapters',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      if (readChapters < widget.manga.totalChapters) {
                        updateReadChapters(readChapters + 1);
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Text(
                'Remaining Chapters: ${widget.manga.totalChapters - readChapters}',
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
                      Provider.of<MangaProvider>(context, listen: false).removeManga(widget.index);
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
