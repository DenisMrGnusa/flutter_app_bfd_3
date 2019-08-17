import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
//import 'package:meta/meta.dart';
import 'serializers.dart';
//import 'package:http/http.dart' as http;

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {

  static Serializer<Article> get serializer => _$articleSerializer;

  int get id;

  @nullable
  bool get deleted;

  String get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Article._();
  factory Article([updates(ArticleBuilder b)]) = _$Article;
}

//it's like mongoose schema, the function is to immutable data
//class Article {
//  final String text;
//  final String url;
//  final String by;
//  final int time;
//  final int score;
//
//  const Article({
//    this.text,
//    this.url,
//    this.by,
//    this.time,
//    this.score
//  });
//
//  factory Article.fromJson(Map<String, dynamic> json){
//    if(json == null) return null;
//
//    return Article(
//      text: json["text"] ?? '[null]',
//      url: json["url"],
//      by: json["by"],
//      time: json["time"],
//      score: json["score"],
//    );
//  }
//}

//get data from API endpoint (dummies)
//Future<Article> fetchData(http.Client client) async {
//  dynamic response = await client.get('https://hacker-news.firebaseio.com/v0/item/8863.json',
//  ).timeout(const Duration(seconds: 5));
//  final parsed = json.decode(response.body);
//  Article article = Article.fromJson(parsed);
//  return article;
//
//}

List<int> parseTopStories(String jsonStr){
  return [];
//  final parsed = json.decode((jsonStr));
//  final listOfIds = List<int>.from(parsed);
//  return listOfIds;
}

Article parseArticle (String jsonStr){
  final parsed = json.decode(jsonStr);
  Article article = standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
