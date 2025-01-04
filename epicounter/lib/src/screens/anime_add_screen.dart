import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/anime_provider.dart';
import './../models/anime.dart';

class AnimeAddScreen extends StatefulWidget {
  @override
  _AnimeAddScreenState createState() => _AnimeAddScreenState();
}

class _AnimeAddScreenState extends State<AnimeAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _episodesController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Anime'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _episodesController,
                decoration: InputDecoration(labelText: 'Total Episodes'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total episodes';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final anime = Anime(
                      title: _titleController.text,
                      totalEpisodes: int.parse(_episodesController.text),
                      watchedEpisodes: 0,
                      imageUrl: _imageUrlController.text,
                    );
                    Provider.of<AnimeProvider>(context, listen: false).addAnime(anime);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Anime'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
