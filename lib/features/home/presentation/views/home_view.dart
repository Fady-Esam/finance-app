import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'home';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).welcome_title,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Navigate to notifications or perform any action
            },
          ),
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              // Navigate to settings or perform any action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(
              //color: Colors.blue,
              // ),
              child: Container(),
            ),
            ListTile(
              title: Text(S.of(context).dark_mode),
              trailing: Switch(
                value: false, 
                onChanged: (value) {
                  // Handle dark mode toggle
                },
              ),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text(S.of(context).all_activities),
              trailing: Icon(Icons.local_activity),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
