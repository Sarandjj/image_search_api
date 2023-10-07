import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiKey =
      'kQQ8cXev3awSM0PqwUokN6vJ4y1ZxFbkUQ_dJW8XlUA'; // Replace with your Unsplash API key

  String _query = ''; // Store the user's search query
  final List<Map<String, dynamic>> _images = [];
  int _currentPage = 1;
  bool _searching = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadMoreImages() async {
    if (_loading) return;
    try {
      setState(() {
        _loading = true;
      });

      final response = await http.get(
        Uri.parse(
          'https://api.unsplash.com/search/photos?query=$_query&page=$_currentPage&per_page=15',
        ),
        headers: {'Authorization': 'Client-ID $apiKey'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final images = results.cast<Map<String, dynamic>>();
        setState(() {
          _images.addAll(images);
          _currentPage++;
        });
      } else {
        throw Exception('Failed to load images');
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Picture Search'),
        //toolbarHeight: 80,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              onChanged: (query) {
                // Update the query as the user types
                setState(() {
                  _query = query;
                });
              },
              onSubmitted: (query) {
                // Trigger search when the user submits the search field
                setState(() {
                  _searching = true; // Indicate searching
                  _images.clear(); // Clear previous results
                  _currentPage = 1; // Reset current page
                });
                _loadMoreImages();
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searching
                ? Stack(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo is ScrollEndNotification &&
                              scrollInfo.metrics.extentAfter == 0) {
                            // User has scrolled to the end, load more images
                            _loadMoreImages();
                          }
                          return false;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              final imageUrl = _images[index]['urls']['small'];
                              return Image.network(
                                imageUrl,
                                fit: BoxFit.fill, // Maintain aspect ratio
                              );
                            },
                          ),
                        ),
                      ),
                      if (_loading)
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: Text(
                      "Enter a search query to get started.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
