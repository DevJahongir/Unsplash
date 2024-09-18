import 'package:flutter/material.dart';
import 'package:unsplash/pages/search_page.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of categories for horizontal scrolling
  final List<String> _categories = [
    "Editorial",
    "Wallpapers",
    "Earth Hour",
    "Spring",
    "Nuture"
  ];

  final List<Widget> _pages = [
    ImageFeedPage(),
    SearchPage(), // Replace with the new search page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pix,color: Colors.white,size: 30,),
            SizedBox(width: 25,),
            Text(
              'Unsplash',
              style: TextStyle(
                fontSize: 40,
                fontFamily: "Metroplex Shadow",
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0, // Make the app bar float smoothly over content
      ),
      body: Column(
        children: [
          // Horizontal ListView for categories
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 50, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle category tap if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[900], // Background for category boxes
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.greenAccent, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // The actual content (image feed or search page)
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        elevation: 0,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
        ],
      ),
    );
  }
}

class ImageFeedPage extends StatelessWidget {
  final List<String> images = [
    'https://images.unsplash.com/photo-1725794288429-5aba98177cbd?q=80&w=1370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1726503454447-6c67b92dcc52?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1666900050146-a26ed38ae97d?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1726441742327-746b1e0d431e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // Add more image URLs or assets
  ];

  ImageFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ImageCard(imageUrl: images[index]);
      },
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;

  const ImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Details Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(imageUrl: imageUrl),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        clipBehavior: Clip.antiAlias, // Rounded corners for images
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 250, // Better control over height
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Image Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
