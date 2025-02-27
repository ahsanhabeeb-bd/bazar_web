import 'package:bazar_web/data/trending_product.dart';
import 'package:bazar_web/pages/widgets/brand_scroll.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> categories = [];
  List<dynamic> _dropdownItems = [];
  List<String> imageUrls1 = [];
  List<String> imageUrls2 = [];
  List<String> imageUrls3 = [];
  List<String> imageUrls4 = [];
  List<String> imageUrls5 = [];

  bool showNames = true;

  @override
  void initState() {
    super.initState();
    showNames = true;
    fetchCategories();
    slide1();
    slide2();
    slide3();
    slide4();
    slide5();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/categories",
    );

    try {
      final response = await http.get(url);
      categories = json.decode(response.body);
      _dropdownItems = categories.map((item) => item['name']).toList();

      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  // Function to Fetch Images from API
  Future<void> slide1() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/slideshow1",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract valid image URLs
        imageUrls1 =
            jsonResponse
                .where(
                  (item) =>
                      item["image"] != null &&
                      item["image"].toString().isNotEmpty,
                )
                .map(
                  (item) =>
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${item["image"]}",
                ) // Correct URL
                .toList();

        print("Fetched Images: $imageUrls1"); // Debugging Output
      } else {
        print("Failed to load slideshow: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slideshow: $e");
    }
  }

  Future<void> slide2() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/slideshow2",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract valid image URLs
        imageUrls2 =
            jsonResponse
                .where(
                  (item) =>
                      item["image"] != null &&
                      item["image"].toString().isNotEmpty,
                )
                .map(
                  (item) =>
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${item["image"]}",
                ) // Correct URL
                .toList();

        print("Fetched Images: $imageUrls2"); // Debugging Output
      } else {
        print("Failed to load slideshow: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slideshow: $e");
    }
  }

  Future<void> slide3() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/slideshow3",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract valid image URLs
        imageUrls3 =
            jsonResponse
                .where(
                  (item) =>
                      item["image"] != null &&
                      item["image"].toString().isNotEmpty,
                )
                .map(
                  (item) =>
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${item["image"]}",
                ) // Correct URL
                .toList();

        print("Fetched Images: $imageUrls3"); // Debugging Output
      } else {
        print("Failed to load slideshow: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slideshow: $e");
    }
  }

  Future<void> slide4() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/slideshow4",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract valid image URLs
        imageUrls4 =
            jsonResponse
                .where(
                  (item) =>
                      item["image"] != null &&
                      item["image"].toString().isNotEmpty,
                )
                .map(
                  (item) =>
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${item["image"]}",
                ) // Correct URL
                .toList();

        print("Fetched Images: $imageUrls4"); // Debugging Output
      } else {
        print("Failed to load slideshow: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slideshow: $e");
    }
  }

  Future<void> slide5() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/slideshow5",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Extract valid image URLs
        imageUrls5 =
            jsonResponse
                .where(
                  (item) =>
                      item["image"] != null &&
                      item["image"].toString().isNotEmpty,
                )
                .map(
                  (item) =>
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${item["image"]}",
                ) // Correct URL
                .toList();

        print("Fetched Images: $imageUrls5"); // Debugging Output
      } else {
        print("Failed to load slideshow: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slideshow: $e");
    }
  }

  double expandedWidth = 200;
  double collapsedWidth = 60;
  TextEditingController _searchController = TextEditingController();
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 70, top: 25, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        width: 100,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.group,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Search Bar & Dropdown
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          value: _selectedItem,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items:
                              _dropdownItems.map<DropdownMenuItem<String>>((
                                dynamic item,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: item as String,
                                  child: Text(item),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                          hint: Text("Select"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 170,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                    ),
                    items:
                        imageUrls1.map((imageUrl) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 10),
                  Row(children: [

                    ],
                  ),

                  // GridView for 4 Containers
                  Row(
                    children: [
                      // First Carousel
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items:
                              imageUrls2.map((imageUrl) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),

                      SizedBox(width: 10), // Spacing between carousels
                      // Second Carousel
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 4),
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items:
                              imageUrls3.map((imageUrl) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      // First Carousel
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items:
                              imageUrls4.map((imageUrl) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),

                      SizedBox(width: 10), // Spacing between carousels
                      // Second Carousel
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 4),
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items:
                              imageUrls5.map((imageUrl) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Brand Scroll Widget
                  Brand_Scroll(),
                  Text("Tranding Products", style: TextStyle(fontSize: 20)),
                  Trending_Product(),
                ],
              ),
            ),
          ),

          // Sidebar Navigation
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: showNames ? expandedWidth : collapsedWidth,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    IconButton(
                      icon: Icon(
                        showNames ? Icons.arrow_back_ios_new : Icons.menu,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          showNames = !showNames;
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          String categoryName = categories[index]["name"]!;
                          String categoryImage =
                              "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${categories[index]["image"]}";

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              minLeadingWidth:
                                  0, // ✅ Prevents leading from consuming full width
                              horizontalTitleGap:
                                  showNames
                                      ? 10
                                      : 0, // ✅ Adjusts spacing when title is hidden
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 50,
                                  maxWidth: 50,
                                  minHeight: 50,
                                  maxHeight: 50,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    categoryImage,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                  ),
                                ),
                              ),
                              title:
                                  showNames
                                      ? Text(
                                        categoryName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                      : null, // ✅ Use `null` instead of `SizedBox()` to prevent layout issues
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
