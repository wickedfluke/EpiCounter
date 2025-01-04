import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/manga_provider.dart';
import 'manga_detail_screen.dart';
import './../models/manga.dart';
import 'manga_add_screen.dart'; // Importiamo la schermata di aggiunta

class MangaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga List'),
        backgroundColor: Colors.black87,
      ),
      body: Consumer<MangaProvider>(
        builder: (context, mangaProvider, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: mangaProvider.mangaList.length,
            itemBuilder: (context, index) {
              Manga manga = mangaProvider.mangaList[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MangaDetailScreen(manga: manga, index: index),
                  ),
                ),
                child: Card(
                  color: Colors.grey[850],
                  child: Column(
                    children: [
                      Image.network(manga.imageUrl, fit: BoxFit.cover),
                      Text(manga.title, style: TextStyle(color: Colors.white)),
                      Text('${manga.readVolumes}/${manga.totalVolumes} volumes', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviga alla schermata di aggiunta manga
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MangaAddScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }
}
