import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/pages/collection_page.dart';
import 'package:unsplash/pages/search_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int _currentTap = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Unsplash",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.pix_outlined,
            color: Colors.white,
          ),
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: [
          SearchPage(),
          CollectionPage(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTap = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.collections)),
        ],
        onTap: (int index) {
          setState(() {
            _currentTap = index;
          });
          _pageController!.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        },
        currentIndex: _currentTap,
        activeColor: Colors.white,
      ),
    );
  }
}
