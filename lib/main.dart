import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app_bfd_3/models/article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<int> _ids = [
    20721736,20721715,20719095,20714367,20714127,20720630,20719348,20712009,20720922,20720095,20722858
  ];

  Future<Article> _getArticle (int id) async {
    final storyUrl = "https://hacker-news.firebaseio.com/v0/item/$id.json";
    final storyRes = await http.get(storyUrl);
    if(storyRes.statusCode == 200) return parseArticle(storyRes.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView(
        children: _ids.map((i) =>
          FutureBuilder<Article>(
            future: _getArticle(i),
            builder: (BuildContext context, AsyncSnapshot<Article> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return _buildItem(snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ).toList(),
      ),
    );
  }

  Widget _buildItem(Article article){
    return Padding(
      key: Key(article.title),
      padding: EdgeInsets.all(16.0),
      child: new ExpansionTile(
        title: Text(article.title),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(article.type),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if(await canLaunch(article.url)) launch(article.url);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
