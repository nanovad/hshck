import 'package:flutter/material.dart';
import 'package:hshck/widgets/good_bad_indicator.dart';

import '../hash_comparison.dart';

class ComparisonBox extends StatelessWidget {
  final String text;
  final GoodBadState goodOrBad;

  const ComparisonBox({super.key, required this.text, required this.goodOrBad});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 2.0,
                color: switch (goodOrBad) {
                  GoodBadState.good => Colors.green,
                  GoodBadState.bad => Colors.red
                })),
        child: SizedBox(
            width: 32.0,
            height: 32.0,
            child: Center(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold)))));
  }
}

class ComparisonPointView extends StatelessWidget {
  final ComparisonPoint comparisonPoint;
  final int? index;

  const ComparisonPointView(
      {super.key, required this.comparisonPoint, this.index});

  @override
  Widget build(BuildContext context) {
    Widget? indexIfVisible = const SizedBox();
    if (index != null) {
      indexIfVisible =
          Text(index!.toString(), style: const TextStyle(fontSize: 14.0));
    }
    return Column(
      children: [
        indexIfVisible,
        ComparisonBox(
            text: comparisonPoint.a,
            goodOrBad:
                comparisonPoint.same ? GoodBadState.good : GoodBadState.bad),
        Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: ComparisonBox(
                text: comparisonPoint.b,
                goodOrBad: comparisonPoint.same
                    ? GoodBadState.good
                    : GoodBadState.bad)),
      ],
    );
  }
}

class ComparisonView extends StatelessWidget {
  final ItemizedHashComparisonResults ihcr;

  const ComparisonView({super.key, required this.ihcr});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            runSpacing: 16.0,
            children: ihcr.comparisons.asMap()
                .map((index, e) { return MapEntry(index, ComparisonPointView(comparisonPoint: e, index: index)); }).values
                .toList()));
  }
}
