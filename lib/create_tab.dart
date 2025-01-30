
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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'shared/image_store.dart';
import 'shared/constants.dart';
import 'loading_skeleton.dart';

// Glowing Search Input Widget
class GlowingSearchInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;

  const GlowingSearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<GlowingSearchInput> createState() => _GlowingSearchInputState();
}

class _GlowingSearchInputState extends State<GlowingSearchInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: SweepGradient(
              center: Alignment.center,
              startAngle: _rotationAnimation.value,
              endAngle: _rotationAnimation.value + 6.28319,
              colors: const [
                Color(0xFF402FB5),
                Colors.transparent,
                Color(0xFFCF30AA),
                Colors.transparent,
                Color(0xFF402FB5),
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF010201),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  if (_isFocused)
                    BoxShadow(
                      color: const Color(0xFFCF30AA).withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Focus(
                onFocusChange: (focused) {
                  setState(() => _isFocused = focused);
                },
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFB6A9B7),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Glowing Create Button Widget
class GlowingCreateButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GlowingCreateButton({
    super.key,
    this.onPressed,
    required this.isLoading,
  });

  @override
  State<GlowingCreateButton> createState() => _GlowingCreateButtonState();
}

class _GlowingCreateButtonState extends State<GlowingCreateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: SweepGradient(
                center: Alignment.center,
                startAngle: _rotationAnimation.value,
                endAngle: _rotationAnimation.value + 6.28319,
                colors: const [
                  Color(0xFF402FB5),
                  Colors.transparent,
                  Color(0xFFCF30AA),
                  Colors.transparent,
                  Color(0xFF402FB5),
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF161329),
                          const Color(0xFF1D1B4B).withOpacity(0.9),
                        ],
                      ),
                      boxShadow: [
                        if (_isHovered)
                          BoxShadow(
                            color: const Color(0xFFCF30AA).withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!widget.isLoading) ...[
                            AnimatedSparkleIcon(),
                            const SizedBox(width: 12),
                            const Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ] else
                            AnimatedSparkleIcon(), // استبدال CircularProgressIndicator بأيقونة اللمعان
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Animated Sparkle Icon
class AnimatedSparkleIcon extends StatefulWidget {
  const AnimatedSparkleIcon({super.key});

  @override
  State<AnimatedSparkleIcon> createState() => _AnimatedSparkleIconState();
}

class _AnimatedSparkleIconState extends State<AnimatedSparkleIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Icon(
            Icons.auto_awesome,
            color: Color.lerp(
              const Color(0xFFCF30AA),
              const Color(0xFF402FB5),
              _scaleAnimation.value - 1,
            ),
            size: 24,
          ),
        );
      },
    );
  }
}

// Shake Animation for Empty Input
class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final bool shouldShake;

  const ShakeAnimation({super.key, required this.child, required this.shouldShake});

  @override
  _ShakeAnimationState createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(ShakeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldShake) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

// Main CreateTab Widget
class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  CreateTabState createState() => CreateTabState();
}

class CreateTabState extends State<CreateTab> with AutomaticKeepAliveClientMixin {
  String _currentMood = "Ethereal";
  final Map<String, String> _moods = AppConstants.moods;

  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _imagePath;

  @override
  bool get wantKeepAlive => true;

  void _selectMood(String mood) {
    setState(() {
      _currentMood = mood;
    });
  }

  Future<void> _shareImage() async {
    try {
      if (_imagePath != null) {
        await Share.shareXFiles(
          [XFile(_imagePath!)],
          text: 'Image created with Dreamscape AI',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _generateImage() async {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a description for the image first.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final startTime = DateTime.now();
    try {
      final fullPrompt = "${_promptController.text}, ${_moods[_currentMood]}";
      final apiUrl = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-3.5-large";
      final token = "HUGGING_FACE_TOKEN";

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({"inputs": fullPrompt}),
      );

      if (response.statusCode == 200) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'generated_${DateTime.now().millisecondsSinceEpoch}.png';
        final filePath = '${appDir.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        final generationTime = DateTime.now().difference(startTime).inMilliseconds / 1000;
        
        final newImage = GeneratedImage(
          imagePath: filePath,
          prompt: _promptController.text,
          mood: _currentMood,
          timestamp: DateTime.now(),
          generationTime: generationTime,
        );

        await ImageStore.addImage(newImage);

        setState(() {
          _imagePath = filePath;
        });
      } else {
        throw Exception("Image creation failed: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20), // تم إضافة مسافة من الأعلى
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                const Color(0xFF402FB5),
                const Color(0xFFCF30AA),
              ],
            ).createShader(bounds),
            child: const Text(
              'Dreamscape AI',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Turn your imagination into art',
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
          const SizedBox(height: 32),
          Text(
            'Choose the mood:',
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _moods.keys.map((mood) {
              return ChoiceChip(
                label: Text(mood),
                selected: _currentMood == mood,
                onSelected: (selected) => _selectMood(mood),
                selectedColor: const Color(0xFF402FB5),
                backgroundColor: Colors.grey[800],
                labelStyle: TextStyle(
                  color: _currentMood == mood ? Colors.white : Colors.grey[400],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          GlowingSearchInput(
            controller: _promptController,
            hintText: 'Enter your creative vision in English',
            onChanged: (value) {
              // Handle text changes if needed
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: ShakeAnimation(
              shouldShake: _promptController.text.isEmpty && _isLoading,
              child: GlowingCreateButton(
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _generateImage,
              ),
            ),
          ),
          const SizedBox(height: 32),
          if (_isLoading) ...[
            const LoadingSkeleton(),
          ] else if (_imagePath != null) ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFCF30AA).withOpacity(0.2),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(_imagePath!)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _shareImage,
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text(
                'Share/Save Image',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF402FB5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
