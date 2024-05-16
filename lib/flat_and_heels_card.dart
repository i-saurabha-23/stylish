import 'package:flutter/material.dart';

class FlatAndHeelsCard extends StatelessWidget {
  const FlatAndHeelsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if the screen width is less than 600 (for mobile)
            if (constraints.maxWidth < 600) {
              return buildMobileLayout();
            } else {
              // For larger screens (desktop)
              return buildDesktopLayout();
            }
          },
        ),
      ),
    );
  }

  Widget buildMobileLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack for image and orange background
        Stack(
          children: [
            Container(
              width: 10,
              height: 200, // Width of yellow color
              color: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/background_image.png', // Replace with your background image asset path
                width: 100, // Adjust the width of the image
                height: 200, // Adjust the height of the image
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/shoes.png', // Replace with your image asset path
                width: 100, // Adjust the width of the image
                height: 200, // Adjust the height of the image
              ),
            ),
          ],
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flat and Heels',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Stand a chance to get rewarded',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle visit now action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Visit now'),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack for image and orange background
        Stack(
          children: [
            Container(
              width: 10,
              height: 200,
              color: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/background_image.png', // Replace with your background image asset path
                    width: 100, // Adjust the width of the image
                    height: 200, // Adjust the height of the image
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Flat and Heels',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Stand a chance to get rewarded',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle visit now action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Visit now'),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/shoes.png', // Replace with your image asset path
                width: 100, // Adjust the width of the image
                height: 200, // Adjust the height of the image
              ),
            ),
          ],
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}
