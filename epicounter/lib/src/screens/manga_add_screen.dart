import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/manga_provider.dart';
import './../models/manga.dart';

class MangaAddScreen extends StatefulWidget {
  @override
  _MangaAddScreenState createState() => _MangaAddScreenState();
}

class _MangaAddScreenState extends State<MangaAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _volumesController = TextEditingController();
  final TextEditingController _chaptersController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Manga'),
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
                controller: _volumesController,
                decoration: InputDecoration(labelText: 'Total Volumes'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total volumes';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _chaptersController,
                decoration: InputDecoration(labelText: 'Total Chapters'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total chapters';
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
                    final manga = Manga(
                      title: _titleController.text,
                      totalVolumes: int.parse(_volumesController.text),
                      totalChapters: int.parse(_chaptersController.text),
                      readVolumes: 0,
                      readChapters: 0,
                      imageUrl: _imageUrlController.text,
                    );
                    Provider.of<MangaProvider>(context, listen: false).addManga(manga);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Manga'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
