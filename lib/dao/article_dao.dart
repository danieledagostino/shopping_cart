import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shopping_cart_manager/models/article.dart';

class ArticleDao {
  //permit to open the database
  //each db is a single file
  DatabaseFactory databaseFactory = databaseFactoryIo;
  Database _db; //db declaration
  //specifiy the store folder of this map (database)
  final store = intMapStoreFactory.store('articoli');

  Future _opendDatabase() async {
    //private method
    //getApplicationDocumentsDirectory method from lib path_provider
    final documentsPath = await getApplicationDocumentsDirectory();

    //join from lib path to concatena with the right separator fro the current system
    final dbPath = join(documentsPath.path, 'articles.db');

    //finally open the db
    final db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

  Future insert(Article article) async {
    Database db = await _opendDatabase();
    int id = await store.add(db, article.toMap());
    return id;
  }

  Future<List<Article>> findAll() async {
    Database db = await _opendDatabase();
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final articles = await store.find(db, finder: finder);
    return articles.map((e) {
      final art = Article.fromMap(e.value);
      art.id = e.key;
      return art;
    }).toList();
  }

  Future update(Article a) async {
    Database db = await _opendDatabase();
    final finder = Finder(filter: Filter.byKey(a.id));
    await store.update(db, a.toMap(), finder: finder);
  }

  Future delete(Article a) async {
    Database db = await _opendDatabase();
    final finder = Finder(filter: Filter.byKey(a.id));
    await store.delete(db, finder: finder);
  }

  Future deleteAll() async {
    Database db = await _opendDatabase();
    await store.delete(db);
  }
}
