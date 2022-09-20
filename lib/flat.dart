import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home.dart';
import 'dart:convert';

class FlatPage extends StatefulWidget {
  const FlatPage({Key? key, required this.flat}) : super(key: key);
  final FlatEntity flat;

  @override
  _FlatPageState createState() => _FlatPageState();
}

class _FlatPageState extends State<FlatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "APARTMENT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.apartment,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(widget.flat.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23))),
                      Image.network(widget.flat.image, fit: BoxFit.cover),
                      Text(widget.flat.price.toString() + " euros",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
