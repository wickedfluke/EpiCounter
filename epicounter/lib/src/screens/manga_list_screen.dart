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
              childAspectRatio: 0.7, // Riduciamo l'aspect ratio
            ),
            itemCount: mangaProvider.mangaList.length,
            itemBuilder: (context, index) {
              Manga manga = mangaProvider.mangaList[index];
              int remainingVolumes = manga.totalVolumes - manga.readVolumes;
              int remainingChapters = manga.totalChapters - manga.readChapters;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Immagine con dimensioni fisse
                      Container(
                        width: double.infinity,
                        height: 180, // Altezza fissa dell'immagine
                        child: Image.network(
                          manga.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Testo sotto l'immagine
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manga.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${manga.readVolumes}/${manga.totalVolumes} volumes read',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              '${manga.readChapters}/${manga.totalChapters} chapters read',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              '$remainingVolumes volumes, $remainingChapters chapters remaining',
                              style: TextStyle(color: Colors.yellow[700], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
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
