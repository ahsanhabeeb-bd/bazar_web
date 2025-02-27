import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final String? description;
  final String? picture1;
  final String? picture2;
  final String? picture3;
  final int quantity;
  final String? vendorPrice;
  final String mrp;
  final String? vendorName;
  final String? categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.picture1,
    required this.picture2,
    required this.picture3,
    required this.quantity,
    required this.vendorPrice,
    required this.mrp,
    required this.vendorName,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      picture1: json['picture1'],
      picture2: json['picture2'],
      picture3: json['picture3'],
      quantity: json['quantity'],
      vendorPrice: json['vendor_price'],
      mrp: json['mrp'],
      vendorName: json['vendor_name'],
      categoryName: json['category_name'],
    );
  }
}

class Trending_Product extends StatefulWidget {
  const Trending_Product({Key? key}) : super(key: key);

  @override
  State<Trending_Product> createState() => _Trending_ProductState();
}

class _Trending_ProductState extends State<Trending_Product> {
  bool isLoading = true;
  List<Product> products = [];
  late List<bool> _isHovered;

  @override
  void initState() {
    super.initState();
    fetchTrendingProducts();
  }

  Future<void> fetchTrendingProducts() async {
    final url = Uri.parse(
      "https://api.allorigins.win/raw?url=https://oboefbazar.com/api/products",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data.map((item) => Product.fromJson(item)).toList();
          _isHovered = List<bool>.filled(products.length, false);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    int crossAxisCount =
        isMobile
            ? 2
            : isTablet
            ? 3
            : 5;
    double childAspectRatio = isMobile ? 0.75 : 0.85;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  String productName = product.name ?? "No name available";
                  String productPrice = product.mrp ?? "0";
                  String productDescription =
                      product.description ?? "No description available";
                  String productImage1 =
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${product.picture1}";

                  String productImage2 =
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${product.picture2}";
                  String productImage3 =
                      "https://api.allorigins.win/raw?url=https://oboefbazar.com/storage/app/public/${product.picture3}";
                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHovered[index] = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHovered[index] = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder:
                        //         (context) => ProductFullDescrip(
                        //           product: {
                        //             'id': product.id,
                        //             'name': product.name,
                        //             'description':
                        //                 product.description ??
                        //                 "No description available",
                        //             'picture1': productImage1,
                        //             'picture2': productImage2,
                        //             'picture3': productImage3,
                        //             'quantity': product.quantity,
                        //             'vendor_price': product.vendorPrice,
                        //             'mrp': product.mrp,
                        //             'vendor_name': product.vendorName,
                        //             'category_name': product.categoryName,
                        //           },
                        //         ),
                        //   ),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                _isHovered[index]
                                    ? Colors.blueAccent
                                    : const Color.fromARGB(255, 205, 205, 205),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,

                              child: Image.network(
                                productImage1,
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName,
                                    style: TextStyle(
                                      fontSize: isMobile ? 14 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '\$${productPrice}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Buy",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          color: Colors.deepOrange,
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Cart",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
