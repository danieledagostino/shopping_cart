import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shopping_cart_manager/models/article.dart';
import 'package:shopping_cart_manager/dao/article_dao.dart';
import 'package:shopping_cart_manager/pages/article_detail_page.dart';

class ArticlesListPage extends StatefulWidget {
  @override
  _ArticlesListPageState createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  ArticleDao dao;

  @override
  void initState() {
    dao = ArticleDao();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailPage(Article('', '', ''), true)));
        },
      ),
      body: FutureBuilder(
          future: findArticles(),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> snap) {
            List<Article> list = snap.data;
            return ListView.builder(
                itemCount: (list == null ? 0 : list.length),
                itemBuilder: (_, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailPage(list[index], false)));
                      },
                      title: Text(list[index].name ?? ''),
                      subtitle: Text('Quantity ' +
                          (list[index].quantity ?? '') +
                          ' note - ' +
                          (list[index].note ?? '')));
                });
          }),
    );
  }

  Future findArticles() async {
    List<Article> articles = await dao.findAll();

    return articles;
  }
}
