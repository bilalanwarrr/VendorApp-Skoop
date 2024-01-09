import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RoomStreamSplash(),
    );
  }
}

class RoomStreamSplash extends StatefulWidget {
  const RoomStreamSplash({super.key});

  @override
  _RoomStreamSplashState createState() => _RoomStreamSplashState();
}

class _RoomStreamSplashState extends State<RoomStreamSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconRotation;
  late Animation<double> _spacingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _spacingAnimation = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _iconRotation = Tween<double>(begin: 0, end: 1 * 3.14).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeInCubic),
      ),
    );
    _controller.forward().whenComplete(() {
      // Navigate to the home screen after the animation completes
      _controller
          .reverse()
          .whenComplete(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 21, 79, 226), // Change the background color as needed
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [_controller, _scaleAnimation, _spacingAnimation]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _iconRotation,
                  child: const Icon(
                    Icons.fiber_smart_record_rounded,
                    size: 60.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Text(
                    'RoomStream',
                    style: TextStyle(
                      fontSize: 24.0 + _scaleAnimation.value,
                      fontWeight: FontWeight.w900,
                      color: Colors.white, // Replace with your desired color
                      letterSpacing: _spacingAnimation.value,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
