
/*
 *  Copyright (c) 2024 Mustafa Arkan. All rights reserved.
 *  
 *  This source code is licensed under the MIT license
 *  found in the LICENSE file in the root directory of this project.
 *  https://www.instagram.com/4m.u1
 *  www.linkedin.com/in/mustafa-arkan
 *
 */





import 'dart:io';
import 'package:flutter/material.dart';
import 'shared/image_store.dart';
import 'shared/constants.dart';

class GalleryTab extends StatefulWidget {
  const GalleryTab({super.key});

  @override
  GalleryTabState createState() => GalleryTabState();
}

class GalleryTabState extends State<GalleryTab> {
  String? selectedMood;
  String searchQuery = "";
  List<GeneratedImage> images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await ImageStore.loadImages();
    setState(() {
      images = ImageStore.getImages();
    });
  }

  List<GeneratedImage> getFilteredImages() {
    return images.where((image) {
      final matchesMood = selectedMood == null || image.mood == selectedMood;
      final matchesSearch = image.prompt.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesMood && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25), // تم إضافة مسافة من الأعلى
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Enter a prompt...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String?>(
                  value: selectedMood,
                  hint: const Text("Filter by Mood"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMood = newValue;
                    });
                  },
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text("All Moods"),
                    ),
                    ...AppConstants.moods.keys.map((String mood) {
                      return DropdownMenuItem<String>(
                        value: mood,
                        child: Text(mood),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: getFilteredImages().length,
              itemBuilder: (context, index) {
                final image = getFilteredImages()[index];
                return _buildImageCard(image);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(GeneratedImage image) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(
                File(image.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  image.prompt,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        image.mood,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue[700],
                    ),
                    Text(
                      "${image.generationTime.toStringAsFixed(1)}s",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  image.timestamp.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
