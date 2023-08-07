import 'dart:math';

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

class ComparisonPoint {
  String a;
  String b;
  bool get same => a == b;

  ComparisonPoint(this.a, this.b);
}

class ItemizedHashComparisonResults {
  List<ComparisonPoint> comparisons;

  ItemizedHashComparisonResults(this.comparisons);

  static ItemizedHashComparisonResults fromHashes(var hashes) {
    String a = hashes.a;
    String b = hashes.b;

    List<ComparisonPoint> lc = List.empty(growable: true);

    for(int i = 0; i < max(a.length, b.length); i++) {
      lc.add(ComparisonPoint(a.characters.elementAtOrNull(i) ?? "", b.characters.elementAtOrNull(i) ?? ""));
    }

    return ItemizedHashComparisonResults(lc);
  }
}
