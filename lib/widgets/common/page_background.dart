import 'package:flutter/material.dart';
import '../../app/theme.dart';

class PageBackground extends StatelessWidget {

  const PageBackground({
    super.key,
    required this.child,
    this.opacity = 0.05,
    this.useScaffold = false,
  });
  final Widget child;
  final double opacity;
  final bool useScaffold;

  @override
  Widget build(BuildContext context) {
    final background = Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        image: DecorationImage(
          image: const AssetImage('assets/images/philippines.png'),
          fit: BoxFit.cover,
          opacity: opacity,
        ),
      ),
      child: child,
    );

    if (useScaffold) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: background,
      );
    }

    return background;
  }
}