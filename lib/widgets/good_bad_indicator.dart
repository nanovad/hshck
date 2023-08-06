import 'package:flutter/material.dart';

enum GoodBadState {
  good,
  bad
}

class GoodBadIndicator extends StatelessWidget {
  final bool state;

  const GoodBadIndicator({super.key, required this.state});
  
  @override
  Widget build(BuildContext context) {
    return Icon(
      state ? Icons.check_circle : Icons.cancel,
      color: state ? Colors.green : Colors.red
    );
  }
}