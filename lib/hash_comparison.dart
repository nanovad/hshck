import 'package:flutter/material.dart';

enum WhichHash {
  A,
  B
}

class HashComparison {
  static HashComparisonResults compareHashes(var hashes) {
    return HashComparisonResults(
      uneven: _checkUneven(hashes),
      unequal: _checkUnequal(hashes)
    );
  }

  static bool _checkUnequal(var hashes) {
    debugPrint("a: ${hashes.a}, b: ${hashes.b}");
    return hashes.a != hashes.b;
  }

  static bool _checkUneven(var hashes) {
    return (hashes.a as String?)?.length != (hashes.b as String?)?.length;
  }
}

class HashComparisonResults {
  bool? uneven;
  bool? unequal;

  bool get good => !(
    (uneven ?? false)
    || (unequal ?? false)
  );

  HashComparisonResults({this.uneven, this.unequal});
}