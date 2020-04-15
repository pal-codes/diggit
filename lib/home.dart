import 'package:diggit/models/meetsModel.dart';
import 'package:diggit/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User> reqsend() async {
    List<User> users;
    var response = await http.get('https://api.github.com/users?per_page=50');
    if (response.statusCode == 200) {
      print('STATUS ON FIRST REQUEST = 200');
      users = (json.decode(response.body) as List)
          .map((i) => User.fromJson(i))
          .toList();
      final random = new Random();
      var theUser = users[random.nextInt(users.length)];
      print(theUser.url);
      var response2 = await http.get(theUser.url);
      var foundUser = Meets.fromJson(json.decode(response2.body));
      print("${foundUser.name} \n ${foundUser.bio}");
    } else {
      print('NULL');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reqsend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Text('Lets see'),
          ],
        ),
      ),
    );
  }
}
