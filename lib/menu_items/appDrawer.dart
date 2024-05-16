import 'package:flutter/material.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              // Handle navigation to Categories
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text('Hot Deals'),
            onTap: () {
              // Handle navigation to Hot Deals
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Summer Special'),
            onTap: () {
              // Handle navigation to Summer Special
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Winter Special'),
            onTap: () {
              // Handle navigation to Winter Special
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.beach_access),
            title: Text('Monsoon Wear'),
            onTap: () {
              // Handle navigation to Monsoon Wear
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.more_horiz),
            title: Text('Other Stuffs'),
            onTap: () {
              // Handle navigation to Other Stuffs
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
