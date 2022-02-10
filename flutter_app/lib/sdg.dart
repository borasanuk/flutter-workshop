import 'package:flutter/material.dart';
import 'package:flutter_app/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<SDG>> fetchSDGs() async {
  final sdgs = <SDG>[];

  final response =
      await http.get(Uri.https("6077378a1ed0ae0017d6aa3b.mockapi.io", "sdgs"));

  final data = jsonDecode(response.body);
  for (Map item in data) {
    sdgs.add(SDG.fromJson(item));
  }
  return sdgs;
}

Future<List<SDG>> searchSDGs(String str) async {
  final sdgs = <SDG>[];

  var queryParameters = {
    "name": str,
  };

  final response =
      await http.get(Uri.https("6077378a1ed0ae0017d6aa3b.mockapi.io", "sdgs", queryParameters));

  final data = jsonDecode(response.body);
  for (Map item in data) {
    sdgs.add(SDG.fromJson(item));
  }
  return sdgs;
}

class SDG {
  final int id;
  final String imgSrc;
  final String name;
  final String desc;

  SDG(
      {required this.id,
      required this.imgSrc,
      required this.name,
      required this.desc});

  factory SDG.fromJson(Map data) {
    return SDG(
        id: int.parse(data["id"]),
        imgSrc: data["icon_src"],
        name: data["name"],
        desc: data["desc"]);
  }
}

class SDGTile extends StatelessWidget {
  final SDG sdg;

  const SDGTile({Key? key, required this.sdg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                child: Image.network(sdg.imgSrc, height: 128)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Goal " + sdg.id.toString(),
                      style: smallTitleStyle,
                    ),
                    Text(sdg.name, style: mediumTitleStyle),
                    const Spacer(),
                    Text(
                      sdg.desc,
                      style: paragraphStyle,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
