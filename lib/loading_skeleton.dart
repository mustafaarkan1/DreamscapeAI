
/*
 *  Copyright (c) 2024 Mustafa Arkan. All rights reserved.
 *  
 *  This source code is licensed under the MIT license
 *  found in the LICENSE file in the root directory of this project.
 *  https://www.instagram.com/4m.u1
 *  www.linkedin.com/in/mustafa-arkan
 *
 */



// loading_skeleton.dart
import 'package:flutter/material.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade800,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: 40,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Title placeholder
          _buildPulseBar(width: 200, height: 20),
          const SizedBox(height: 12),
          // Description placeholders
          _buildPulseBar(width: double.infinity, height: 10),
          const SizedBox(height: 8),
          _buildPulseBar(width: double.infinity, height: 10),
          const SizedBox(height: 8),
          _buildPulseBar(width: 180, height: 10),
          const SizedBox(height: 16),
          // Bottom info section
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPulseBar(width: 120, height: 10),
                  const SizedBox(height: 6),
                  _buildPulseBar(width: 180, height: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPulseBar({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: _PulseAnimation(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;

  const _PulseAnimation({required this.child});

  @override
  _PulseAnimationState createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
