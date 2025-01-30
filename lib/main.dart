
/*
 *  Copyright (c) 2024 Mustafa Arkan. All rights reserved.
 *  
 *  This source code is licensed under the MIT license
 *  found in the LICENSE file in the root directory of this project.
 *  https://www.instagram.com/4m.u1
 *  www.linkedin.com/in/mustafa-arkan
 *
 */


import 'package:flutter/material.dart';
import 'about_tab.dart';
import 'create_tab.dart';
import 'gallery_tab.dart';
import 'shared/image_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImageStore.loadImages();
  runApp(const DreamscapeApp());
}

class DreamscapeApp extends StatelessWidget {
  const DreamscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dreamscape AI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'CustomFont'),
          displayMedium: TextStyle(fontFamily: 'CustomFont'),
          displaySmall: TextStyle(fontFamily: 'CustomFont'),
          headlineLarge: TextStyle(fontFamily: 'CustomFont'),
          headlineMedium: TextStyle(fontFamily: 'CustomFont'),
          headlineSmall: TextStyle(fontFamily: 'CustomFont'),
          titleLarge: TextStyle(fontFamily: 'CustomFont'),
          titleMedium: TextStyle(fontFamily: 'CustomFont'),
          titleSmall: TextStyle(fontFamily: 'CustomFont'),
          bodyLarge: TextStyle(fontFamily: 'CustomFont'),
          bodyMedium: TextStyle(fontFamily: 'CustomFont'),
          bodySmall: TextStyle(fontFamily: 'CustomFont'),
          labelLarge: TextStyle(fontFamily: 'CustomFont'),
          labelMedium: TextStyle(fontFamily: 'CustomFont'),
          labelSmall: TextStyle(fontFamily: 'CustomFont'),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe between tabs
        children: const [
          CreateTab(),
          GalleryTab(),
          AboutTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
