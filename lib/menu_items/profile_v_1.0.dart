import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink.shade200,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.pink),
                    title: Text('My Account'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Navigate to My Account page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.pink),
                    title: Text('My Orders'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Navigate to My Orders page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.pink),
                    title: Text('Favorites'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Navigate to Favorites page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.pink),
                    title: Text('Settings'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Navigate to Settings page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.help, color: Colors.pink),
                    title: Text('Help & Support'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Navigate to Help & Support page
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.pink),
                    title: Text('Logout'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                    onTap: () {
                      // Handle logout
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
