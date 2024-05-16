import 'package:flutter/material.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  State<ShowProducts> createState() => ShowProductsState();
}

class ShowProductsState extends State<ShowProducts> {
  // Sample product data
  static final List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/img1.png',
      'title': 'Product 1',
      'description': 'Description for product 1',
      'actualPrice': 100.0,
      'discountedPrice': 75.0,
      'discountPercentage': 25,
      'rating': 4.5,
      'numRatings': 120,
    },
    {
      'image': 'assets/img2.png',
      'title': 'Product 2',
      'description': 'Description for product 2',
      'actualPrice': 150.0,
      'discountedPrice': 90.0,
      'discountPercentage': 40,
      'rating': 4.0,
      'numRatings': 80,
    },
    {
      'image': 'assets/img3.png',
      'title': 'Product 3',
      'description': 'Description for product 3',
      'actualPrice': 200.0,
      'discountedPrice': 160.0,
      'discountPercentage': 20,
      'rating': 3.5,
      'numRatings': 50,
    },
    {
      'image': 'assets/img4.png',
      'title': 'Product 4',
      'description': 'Description for product 4',
      'actualPrice': 250.0,
      'discountedPrice': 200.0,
      'discountPercentage': 20,
      'rating': 5.0,
      'numRatings': 200,
    },
  ];

  static List<Map<String, dynamic>> getProducts() {
    return _products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // For mobile layout
            return ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return buildProductCard(context, product);
              },
            );
          } else {
            // For desktop layout
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return buildProductCard(context, product);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle product tap
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                product['image'],
                fit: BoxFit.cover,
                height: 150.0,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product['description'],
                    style: Theme.of(context).textTheme.subtitle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        '\$${product['actualPrice']}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '\$${product['discountedPrice']}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '(${product['discountPercentage']}% off)',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '${product['rating']} (${product['numRatings']} ratings)',
                        style: TextStyle(
                          color: Colors.grey,
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
    );
  }
}
