import 'package:flutter/material.dart';
import 'package:hshck/hash_comparison.dart';
import 'package:hshck/widgets/comparison_view.dart';
import 'package:hshck/widgets/good_bad_indicator.dart';
import 'package:hshck/widgets/labeled_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hshck',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hshck'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? hashA;
  String? hashB;

  HashComparisonResults? hcr;

  bool showResultsDisplay = false;

  void _performComparison() {
    setState(() {
      hcr = HashComparison.compareHashes((a: hashA, b: hashB));
      debugPrint("hcr: unequal ${hcr?.unequal}, uneven: ${hcr?.uneven}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(widget.title),
        ),
        body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // "Hash A" TextField
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(hintText: "Hash A"),
                        style: const TextStyle(fontFamily: "Roboto Mono"),
                        autocorrect: false,
                        onChanged: (value) {
                          hashA = value;
                          _performComparison();
                        },
                      )),
                  // "Hash B" TextField
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(hintText: "Hash B"),
                        style: const TextStyle(fontFamily: "Roboto Mono"),
                        autocorrect: false,
                        onChanged: (value) {
                          hashB = value;
                          _performComparison();
                        },
                      )),
                  // Options bar (currently only detail view toggle)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    LabeledIconSwitch(
                        label: const Text("Character-by-character comparison"),
                        activeIcon: const Icon(Icons.visibility),
                        inactiveIcon: const Icon(Icons.visibility_off),
                        value: showResultsDisplay,
                        onChanged: (state) {
                          setState(() {
                            showResultsDisplay = state;
                          });
                        })
                  ]),
                  // Results indicator
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: GoodBadIndicator(
                        state: (hcr?.good ?? true),
                        size: 64,
                      )),
                  // Results display
                  // Not present in element tree if showResultsDisplay is false
                  showResultsDisplay
                      ? Flexible(
                          child: ComparisonView(
                              ihcr: ItemizedHashComparisonResults.fromHashes(
                                  (a: hashA ?? "", b: hashB ?? ""))))
                      : const SizedBox()
                ],
              )),
        ));
  }
}
