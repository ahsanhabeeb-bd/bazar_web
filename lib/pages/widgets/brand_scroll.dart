import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Brand_Scroll extends StatefulWidget {
  const Brand_Scroll({super.key});

  @override
  State<Brand_Scroll> createState() => _Brand_ScrollState();
}

class _Brand_ScrollState extends State<Brand_Scroll> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  List<String> brands = []; // Stores fetched brand names

  // Tracks hover state for each container
  final Map<int, bool> _hovering = {};

  @override
  void initState() {
    super.initState();
    fetchBrands(); // Fetch brand names from API

    // Auto-scrolling logic
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.offset;

        if (currentPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentPosition + 100, // Scroll by 100 pixels
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(0); // Reset to the start
        }
      }
    });
  }

  // Function to Fetch Brands from API
  Future<void> fetchBrands() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/brands",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract brand names
        setState(() {
          brands =
              jsonResponse
                  .where((item) => item["name"] != null)
                  .map((item) => item["name"].toString())
                  .toList();

          // Initialize hover states
          for (var i = 0; i < brands.length; i++) {
            _hovering[i] = false;
          }
        });

        print("✅ Fetched Brands: $brands"); // Debugging Output
      } else {
        print("❌ Failed to load brands: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error fetching brands: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:
          brands.isEmpty
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loader if empty
              : ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _hovering[index] = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _hovering[index] = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.transparent, // Make container invisible
                      ),
                      child: Center(
                        child: Text(
                          brands[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                _hovering[index] ?? false
                                    ? Colors.black
                                    : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: brands.length,
                scrollDirection: Axis.horizontal,
              ),
    );
  }
}
