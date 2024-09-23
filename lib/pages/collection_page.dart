import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/pages/photos_page.dart';
import 'package:unsplash/services/log_service.dart';

import '../model/collection_model.dart';
import '../services/http_service.dart';

class CollectionPage extends StatefulWidget {
  static const String id = "collection_page";

  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  bool isLoading = false;
  List<Collection> items = [];

  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  _callPhotosPage(Collection collection) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PhotosPage(
        collection: collection,
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
          currentPage++;
          LogService.i(currentPage.toString());
          _apiCollectionList();
        }
      }
    });
    _apiCollectionList();
  }

  _apiCollectionList() async {
    var response = await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections(currentPage));
    var result = Network.parseCollections(response!);
    LogService.i(response!);

    setState(() {
      items.addAll(result);
      isLoading = false;  // Stop the loading indicator
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemOfCollection(items[index]);
              },
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }

  Widget itemOfCollection(Collection collection) {
    return GestureDetector(
      onTap: () {
        _callPhotosPage(collection);
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  collection.coverPhoto.urls.small!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 2,
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black54,
                Colors.black12,
              ])),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      collection.title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
