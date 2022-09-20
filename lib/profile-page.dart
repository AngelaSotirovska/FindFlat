import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home.dart';
import 'dart:convert';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, required this.title, this.user})
      : super(key: key);
  final String title;
  final User? user;

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List<FlatEntity> searchList = [];

  void _search() async {
    searchList = await fetchFlatSearch('');
    if (mounted)
      setState(() {
        searchList = searchList;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.pinkAccent])),
              child: Container(
                width: double.infinity,
                height: 250.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-05.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "@" + widget.user!.username,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Number of listings: 3",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black) // Background color
                            ),
                        child: const Text('Одјави се'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your listings:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      itemBuilder: (BuildContext context, int index) =>
                          new FlatItemWidget(searchList[index]),
                      itemCount: searchList.length,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    ));
  }
}

class FlatItemWidget extends StatelessWidget {
  final FlatEntity _entity;

  FlatItemWidget(this._entity);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
            child: ListTile(
                leading: Text(_entity.title,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                trailing: Text(_entity.price.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 20))),
          )
        ]));
  }
}

class FlatEntity {
  String city;
  String municipality;
  int price;
  String title;

  FlatEntity(
      {required this.city,
      required this.municipality,
      required this.price,
      required this.title});

  factory FlatEntity.fromJson(Map<String, dynamic> json) => FlatEntity(
      city: json["City"],
      municipality: json["Municipality"],
      price: json["Price"],
      title: json["Title"]);
}

Future<List<FlatEntity>> fetchFlatSearch(search) async {
  final response = await http.get(Uri.parse(
      'https://myflat-d6495-default-rtdb.europe-west1.firebasedatabase.app/flats.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final flats = json.decode(response.body) as Map<String, dynamic>;
    final List<FlatEntity> loadedFlats = [];
    flats.forEach((flatId, flatDetails) {
      loadedFlats.add(FlatEntity(
          city: flatDetails['City'],
          municipality: flatDetails['Manupacity'],
          price: flatDetails['Price'],
          title: flatDetails['Title']));
    });
    final flatsSearch = loadedFlats
        .where((i) => i.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    print(flatsSearch);
    return flatsSearch;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load flats');
  }
}
