import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GeneratedImage {
  final String imagePath;
  final String prompt;
  final String mood;
  final DateTime timestamp;
  final double generationTime;

  GeneratedImage({
    required this.imagePath,
    required this.prompt,
    required this.mood,
    required this.timestamp,
    required this.generationTime,
  });

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'prompt': prompt,
    'mood': mood,
    'timestamp': timestamp.toIso8601String(),
    'generationTime': generationTime,
  };

  factory GeneratedImage.fromJson(Map<String, dynamic> json) => GeneratedImage(
    imagePath: json['imagePath'],
    prompt: json['prompt'],
    mood: json['mood'],
    timestamp: DateTime.parse(json['timestamp']),
    generationTime: json['generationTime'].toDouble(),
  );
}

class ImageStore {
  static const String _fileName = 'generated_images.json';
  static List<GeneratedImage> _images = [];
  
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  static Future<void> loadImages() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = json.decode(contents);
        _images = jsonList.map((json) => GeneratedImage.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  static Future<void> saveImages() async {
    try {
      final file = await _localFile;
      final jsonList = _images.map((image) => image.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      print('Error saving images: $e');
    }
  }

  static List<GeneratedImage> getImages() => _images;

  static Future<void> addImage(GeneratedImage image) async {
    _images.insert(0, image);
    await saveImages();
  }
}