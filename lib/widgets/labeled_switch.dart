import 'package:flutter/material.dart';

class LabeledIconSwitch extends StatelessWidget {
  final Text label;

  final EdgeInsets? padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  final Icon? activeIcon;
  final Icon? inactiveIcon;

  const LabeledIconSwitch(
      {super.key,
      this.padding,
      required this.label,
      required this.value,
      required this.onChanged,
      this.activeIcon,
      this.inactiveIcon});

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
        child: InkWell(
            onTap: () {
              onChanged(!value);
            },
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: label),
              Switch(
                  value: value,
                  thumbIcon: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.selected)
                          ? activeIcon
                          : inactiveIcon),
                  onChanged: onChanged),
            ])));
  }
}
