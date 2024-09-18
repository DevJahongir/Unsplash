import 'package:flutter/material.dart';
import 'package:unsplash/pages/details_page.dart';

class SearchPage extends StatelessWidget {
  final List<String> images = [
    'https://plus.unsplash.com/premium_photo-1698406096055-91a364147db5?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1698405316329-fd9c43d7e11c?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1721332154191-ba5f1534266e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1726148153379-c1a513d6dc4e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  final List<String> names = [
    'wu yi',
    'Adam Bignell',
    'Annie Spratt',
    'Building',
  ];

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Implement your search functionality here
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Search photos, collections, users',
                prefixIcon: const Icon(Icons.search, size: 25), // Adjust icon size here
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            )

          ),
          // Grid of images
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ImageGridItem(
                  imageUrl: images[index],
                  name: names[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImageGridItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ImageGridItem({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Details Page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(imageUrl: imageUrl)));
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
         Hero(
           tag: imageUrl,
           child: Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: NetworkImage(imageUrl),
                 fit: BoxFit.cover,
               )
             ),
           ),
         ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
