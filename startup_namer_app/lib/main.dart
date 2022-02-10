import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final names = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18, fontFamily: "Oswald", fontWeight: FontWeight.w700);

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListView.builder(itemBuilder: (BuildContext context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        if (i >= names.length) {
          names.addAll(generateWordPairs().take(15));
        }

        return _buildRow(names[i ~/ 2]);
      }),
    );
  }

  Widget _buildRow(WordPair str) {
    return ListTile(
        title: Text(
      str.asPascalCase,
      style: _biggerFont,
    ));
  }

  void refresh() {
    setState(() {
      names.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Startup Name Generator")),
        body: _buildSuggestions(),
        floatingActionButton: FloatingActionButton(
            onPressed: refresh, child: const Icon(Icons.refresh)));
  }
}
