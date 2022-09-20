import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:myflat/login_page.dart';

import 'home.dart';

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

_postFlatAd() async {
  try {
    var response = await http.post(
        Uri.parse(
            "https://myflat-d6495-default-rtdb.europe-west1.firebasedatabase.app/users.json"),
        body: json.encode({
          "username": nameController.value.text,
          "password": passwordController.value.text
        }));
    print("Response: ");
    print(response.body);
    return response;
  } catch (e) {
    print(e);
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String _title = 'Најди стан';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

// class User {
//   String username;
//   String password;

//   User({required this.username, required this.password});

//   //factory User.fromJson(Map<String, dynamic> json) => User(username: json["username"], password: json["password"]);
// }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: new EdgeInsets.symmetric(vertical: 40.0),
                child: const Text(
                  'Најди стан',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Регистрирај се',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Корисничко име',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Лозинка',
                ),
              ),
            ),
            Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                    ),
                    child: const Text('Регистрирај се'),
                    onPressed: () {
                      _postFlatAd();
                      User user = new User(
                          username: nameController.value.text,
                          password: passwordController.value.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(user: user),
                        ),
                      );
                    })),
            Row(
              children: <Widget>[
                const Text('Веќе сте корисник?'),
                TextButton(
                  child: const Text(
                    'Логирај се',
                    // style: TextStyle(fontSize: 20),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red // this is for your text colour
                        ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
