import 'package:flutter/material.dart';

customAppBar() {
  return AppBar(
    title:
        SizedBox(width: 220, child: Image.asset('assets/images/web_logo.png')),
    centerTitle: true,
  );
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Container(
        color: const Color.fromARGB(255, 241, 236, 236),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Image.asset(
                'assets/images/app_logo.jpeg',
                width: double.infinity,
                height: 200, // Set the height of the header
                fit: BoxFit.cover, // Use cover for best fit
              ),
            ),
            ListTile(
              title: const Text('Log in', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle log in action
              },
            ),
            ListTile(
              title: const Text('Sign in', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle sign in action
              },
            ),
            ListTile(
              title: const Text('Profile', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle profile action
              },
            ),
            ListTile(
              title:
                  const Text('Sign out', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle sign out action
              },
            ),
          ],
        ),
      ),
    );
  }
}
