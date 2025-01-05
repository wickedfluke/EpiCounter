import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const HomeWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 100,
            width: 170,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            description,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
