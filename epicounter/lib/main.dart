import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './src/providers/anime_provider.dart';
import './src/screens/anime_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnimeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EpiCounter',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF2C2C2C),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFE7B916),
          ),
        ),
        home: AnimeListScreen(),
      ),
    );
  }
}
