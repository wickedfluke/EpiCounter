import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './src/providers/anime_provider.dart';
import './src/providers/manga_provider.dart';
import './src/screens/anime_list_screen.dart';
import './src/screens/manga_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimeProvider()),
        ChangeNotifierProvider(create: (_) => MangaProvider()),
      ],
      child: MaterialApp(
        title: 'Anime & Manga Tracker',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(color: Colors.black87),
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Anime & Manga Tracker'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Anime'),
                  Tab(text: 'Manga'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AnimeListScreen(),
                MangaListScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
