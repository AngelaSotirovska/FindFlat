import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:myflat/flat.dart';
import 'login_page.dart';
import 'home.dart';
import 'dart:convert';

getCities() async {
  return await fetchCity();
}

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext? scaffoldContext;

  Widget build(BuildContext context) {
    return FutureBuilder<List<FlatEntity>>(
      future: fetchFlat(),
      builder:
          (BuildContext context, AsyncSnapshot<List<FlatEntity>> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                FlatEntity flat = snapshot.data![index];
                return Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                        ),
                        child: ListTile(
                          leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 44,
                                minHeight: 64,
                                maxWidth: 64,
                                maxHeight: 100,
                              ),
                              child:
                                  Image.network(flat.image, fit: BoxFit.cover)),
                          title: Text(flat.title),
                          subtitle: Text(flat.price.toString()),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FlatPage(flat: flat)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
