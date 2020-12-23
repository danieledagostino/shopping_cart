import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shopping_cart_manager/models/article.dart';
import 'package:shopping_cart_manager/dao/article_dao.dart';
import 'package:shopping_cart_manager/pages/article_detail_page.dart';
import 'package:shopping_cart_manager/pages/articles_list_page.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;
  final bool newArticle;

  ArticleDetailPage(this.article, this.newArticle);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtQuantity = TextEditingController();

  @override
  void initState() {
    if (!widget.newArticle) {
      txtName.text = widget.article.name ?? '';
      txtNote.text = widget.article.note ?? '';
      txtQuantity.text = widget.article.quantity ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Article detail')),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: saveArticle,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardText(txtName, 'Name'),
              CardText(txtNote, 'Note'),
              CardText(txtQuantity, 'Quantity')
            ],
          ),
        ));
  }

  Future saveArticle() async {
    ArticleDao dao = ArticleDao();

    widget.article.name = txtName.text;
    widget.article.note = txtNote.text;
    widget.article.quantity = txtQuantity.text;

    if (widget.newArticle) {
      await dao.insert(widget.article);
    } else {
      await dao.update(widget.article);
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ArticlesListPage()));
  }
}

class CardText extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  CardText(this.controller, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
        ),
      ),
    );
  }
}
