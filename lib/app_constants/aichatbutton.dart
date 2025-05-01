import 'package:flutter/material.dart';

class Aichatbutton extends StatefulWidget {
  final VoidCallback onPressed;

  const Aichatbutton({super.key, required this.onPressed});

  @override
  AichatbuttonState createState() => AichatbuttonState();
}

class AichatbuttonState extends State<Aichatbutton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat(reverse: true);

    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alignmentAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: _alignmentAnimation.value,
                end: Alignment.centerRight,
                colors: [
                  Colors.greenAccent,
                  Colors.green,
                  Colors.teal,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues().withAlpha((255 * 0.4).round()),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chat_bubble, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Ask AI chatbot',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
