import 'package:flutter/material.dart';

enum GoodBadState {
  good,
  bad
}

class GoodBadIndicator extends StatelessWidget {
  final bool state;
  final double? size;

  const GoodBadIndicator({super.key, required this.state, this.size});
  
  @override
  Widget build(BuildContext context) {
    return Icon(
      state ? Icons.check_circle : Icons.cancel,
      color: state ? Colors.green : Colors.red,
      size: size,
      semanticLabel: state ? "Hash OK icon" : "Hash mismatch icon",
    );
  }
}