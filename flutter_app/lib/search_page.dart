import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/sdg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("United Nations"),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontFamily: "Oswald"),
      ),
      body: ListView(
        primary: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(onChanged: (str) {
                  setState(() {
                    query = str;
                  });
                },),
              )
            ),
          ),
          FutureBuilder(
            future: searchSDGs(query),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    primary: false,
                      shrinkWrap: true,
                      children:
                          snapshot.data!.map((e) => SDGTile(sdg: e)).toList()),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
