import 'package:flutter/material.dart';
import '../models/anime.dart';

class ArcListTile extends StatelessWidget {
  final Arc arc;

  const ArcListTile({required this.arc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(arc.name),
      subtitle: Text("Episodi: ${arc.episodesWatched}/${arc.totalEpisodes}"),
    );
  }
}
