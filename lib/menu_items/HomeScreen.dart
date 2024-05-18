import 'package:flutter/material.dart';
import 'package:stylish/ImageCardView.dart';
import 'package:stylish/SponseredView.dart';
import 'package:stylish/flat_and_heels_card.dart';
import 'package:stylish/homePage_v_1.0.dart';
import 'package:stylish/menu_items/appDrawer.dart';
import 'package:stylish/menu_items/profile_v_1.0.dart';
import 'package:stylish/menu_items/showProducts.dart';
import 'dart:async';

import 'package:stylish/special_offers_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  String _hintText = "Search for products";
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  // Sample data for the horizontal list view
  final List<String> _items = [
    "T-shirt",
    "Jeans",
    "Jacket",
    "Sweater",
    "Shirt",
    "Dress",
    "Skirt",
    "Shorts",
    "Blazer",
    "Shoes"
  ];

  // Sample data for the image carousel
  final List<String> _carouselImages = [
    'assets/banner1.jpeg',
    'assets/banner2.jpeg',
    'assets/banner3.jpeg',
    'assets/banner4.jpeg',
  ];

  // Sample data for categories
  final List<String> _categories = [
    "Men",
    "Women",
    "Kids",
    "Accessories",
    "Sale"
  ];

  // Deal of the Day timer
  late Timer _dealTimer;
  Duration _dealDuration = Duration(hours: 22, minutes: 55, seconds: 20);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _carouselImages.length - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });

    // Initialize the deal timer
    _dealTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_dealDuration.inSeconds > 0) {
          _dealDuration = _dealDuration - Duration(seconds: 1);
        } else {
          _dealTimer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _dealTimer.cancel();
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _sortProducts(List<Map<String, dynamic>> products) {
    setState(() {
      // Sort logic can be improved as needed
      products.sort((a, b) => a['title'].compareTo(b['title']));
    });
  }

  void _filterProducts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Products"),
          content: SingleChildScrollView(
            child: Column(
              children: _categories.map((category) {
                return CheckboxListTile(
                  title: Text(category),
                  value: false,
                  onChanged: (bool? value) {
                    // Implement filtering logic here
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement apply filter logic here
                Navigator.of(context).pop();
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch products from ShowProducts
    final products = ShowProductsState.getProducts();
    final sampleProducts =
        products.length > 7 ? products.sublist(0, 7) : products;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.style),
              SizedBox(width: 10),
              Text("Stylish"),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: _hintText,
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white.withAlpha(235),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Featured",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _sortProducts(sampleProducts),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.sort),
                                  SizedBox(width: 5),
                                  Text("Sort"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: _filterProducts,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.filter_list),
                                  SizedBox(width: 5),
                                  Text("Filter"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50, // Height of the categories list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(_categories[index]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10), // Spacer between categories and carousel
              // Carousel Slider
              SizedBox(
                height: 200, // Adjusted height for carousel container
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _carouselImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _carouselImages[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(
                  height: 10), // Spacer between carousel and deal of the day
              // Deal of the Day section
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deal of the Day",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 16, // Adjust the size of the icon
                                ),
                                SizedBox(
                                    width:
                                        5), // Adjust spacing between icon and text
                                Text(
                                  "${_formatDuration(_dealDuration)} remaining",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle View All action
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "View all",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height:
                      10), // Spacer between deal of the day and sample products list
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 240, // Height of the product list
                child: Stack(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sampleProducts.length,
                      itemBuilder: (context, index) {
                        final product = sampleProducts[index];
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    product['image'] ??
                                        '', // Ensure non-null value
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product['title'] ??
                                      'No title', // Ensure non-null value
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product['description'] ??
                                      'No description', // Ensure non-null value
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product['actualPrice']?.toStringAsFixed(2) ?? 'N/A'}', // Ensure non-null value
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '\$${product['discountedPrice']?.toStringAsFixed(2) ?? 'N/A'}', // Ensure non-null value
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '(${product['discountPercentage']?.toString() ?? '0'}% off)',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14.0,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${product['rating']?.toString() ?? '0'}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '(${product['numRatings']?.toString() ?? '0'} ratings)',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowProducts()),
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height:
                      20), // Spacer between product list and special offers card
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Set width to 90% of screen width
                  child: SpecialOffersCard(),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Set width to 90% of screen width
                  child: FlatAndHeelsCard(),
                ),
              ),

              SizedBox(
                  height: 10), // Spacer between carousel and deal of the day
              // Deal of the Day section
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trending Products",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 16, // Adjust the size of the icon
                                ),
                                SizedBox(
                                    width:
                                        5), // Adjust spacing between icon and text
                                Text(
                                  "Last Date 29/02/22",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle View All action
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "View all",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 240, // Height of the product list
                child: Stack(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sampleProducts.length,
                      itemBuilder: (context, index) {
                        final product = sampleProducts[index];
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    product['image'] ??
                                        '', // Ensure non-null value
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product['title'] ??
                                      'No title', // Ensure non-null value
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product['description'] ??
                                      'No description', // Ensure non-null value
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product['actualPrice']?.toStringAsFixed(2) ?? 'N/A'}', // Ensure non-null value
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '\$${product['discountedPrice']?.toStringAsFixed(2) ?? 'N/A'}', // Ensure non-null value
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '(${product['discountPercentage']?.toString() ?? '0'}% off)',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14.0,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${product['rating']?.toString() ?? '0'}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '(${product['numRatings']?.toString() ?? '0'} ratings)',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowProducts()),
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Set width to 90% of screen width
                  child: ImageCardView(),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Set width to 90% of screen width
                  child: SponseredView(),
                ),
              ), // Add the SpecialOffersCard here
            ],
          ),
        ),
      ),
    );
  }
}
