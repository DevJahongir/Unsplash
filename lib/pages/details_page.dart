import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http; // Add this import

class DetailsPage extends StatelessWidget {
  final String imageUrl;

  const DetailsPage({super.key, required this.imageUrl});

  // Function to save the image to the gallery
  Future<void> _saveImage(BuildContext context) async {
    try {
      // Download the image
      var response = await http.get(Uri.parse(imageUrl)); // Use http here
      var documentDirectory = await getApplicationDocumentsDirectory();
      String path = '${documentDirectory.path}/image.png';

      // Save the image as a file
      File file = File(path);
      file.writeAsBytesSync(response.bodyBytes);

      // Save the image to the gallery
      await GallerySaver.saveImage(file.path);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved to gallery!')),
      );
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save image!')),
      );
      print("Error saving image: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          "Image Details",
          style: TextStyle(fontFamily: "Metroplex Shadow", color: Colors.white, fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          // The full-size image
          Center(
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),

            ),
          ),
          // Positioned download button at the bottom-right
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _saveImage(context),
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              child: const Icon(Icons.download, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
