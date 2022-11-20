import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapi/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _post = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    final String api =
        "https://newsapi.org/v2/everything?q=valorant&from=2022-10-20&sortBy=publishedAt&apiKey=cf00ce1b056f42b382e1ecfb7a7a8701";
    try {
      final response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _post = data['articles'];
        });
        print(_post);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESTFUL API'),
      ),
      body: ListView.builder(
        itemCount: _post.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              color: Colors.grey[200],
              height: 100,
              width: 100,
              child: _post[index]['urlToImage'] != null
                  ? Image.network(
                      _post[index]['urlToImage'],
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Center(),
            ),
            title: Text(
              '${_post[index]['title']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${_post[index]['description']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                      Url: _post[index]['url'],
                      title: _post[index]['title'],
                      content: _post[index]['content'],
                      publishedAt: _post[index]['publishedAt'],
                      author: _post[index]['author'],
                      urlToImage: _post[index]['urlToImage']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
