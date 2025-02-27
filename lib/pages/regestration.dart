import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> categories = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse("https://oboefbazar.com/api/categorieslist");

    try {
      final response = await http.get(url);
      categories = json.decode(response.body);
      debugPrint("Categories: $categories");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
          debugPrint("Categories: $categories");
          debugPrint(response.statusCode.toString());
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading
              : hasError
              ? Center(child: Text("Failed to load categories")) // Show error
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading:
                          category["image"] != null
                              ? Image.network(
                                "https://oboefbazar.com/storage/app/public/${category["image"]}",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    ),
                              )
                              : Icon(Icons.image, size: 50),
                      title: Text(
                        category["name"] ?? "No Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        print("Selected Category: ${category["name"]}");
                      },
                    ),
                  );
                },
              ),
    );
  }
}
