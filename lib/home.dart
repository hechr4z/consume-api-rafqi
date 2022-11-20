import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapi/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _posts = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Http')),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              color: Colors.grey[200],
              height: 100,
              width: 100,
            ),
            title: Text('${_posts[index]['title']}'),
            subtitle: Text('${_posts[index]['description']}'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => Detail()));
            },
          );
        },
      ),
    );
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=valorant&from=2022-10-20&sortBy=publishedAt&apiKey=cf00ce1b056f42b382e1ecfb7a7a8701'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
