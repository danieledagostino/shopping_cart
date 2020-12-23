import 'package:flutter/material.dart';
import 'package:shopping_cart_manager/dao/article_dao.dart';
import 'package:shopping_cart_manager/models/article.dart';
import 'package:shopping_cart_manager/pages/articles_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ArticlesListPage());
  }
}

class DbTest extends StatefulWidget {
  @override
  _DbTestState createState() => _DbTestState();
}

class _DbTestState extends State<DbTest> {
  int id;

  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Shopping cart')),
        body: Center(child: Container(child: Text(id.toString()))));
  }

  Future test() async {
    ArticleDao dao = ArticleDao();
    Article a = Article('Arance', '2Kg', 'Da spremuta');
    id = await dao.insert(a);

    setState(() {
      id = id;
    });
  }
}
