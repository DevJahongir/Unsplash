import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unsplash/model/photo_model.dart';


class DetailsPage extends StatefulWidget {
  static const String id = "details_page";
  final Photo? photo;

  const DetailsPage({super.key, this.photo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // Method to save image to gallery
  Future<void> _saveImage(BuildContext context) async {
    try {
      // Download the image using the photo's URL
      var response = await http.get(Uri.parse(widget.photo!.urls.full!));
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.photo!.description != null ? widget.photo!.description! : 'No name',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()  {
             Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.ios_share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              widget.photo!.urls.full!,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _saveImage(context); // Call save image
                      },
                      icon: const Icon(
                        size: 30,
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
