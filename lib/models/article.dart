class Article {
  int id;
  String name;
  String quantity;
  String note;

  Article(this.name, this.quantity, this.note);

  Map<String, dynamic> toMap() {
    return {'id': id ?? null, 'name': name, 'quantity': quantity, 'note': note};
  }

  Article.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.quantity = map['quantity'];
    this.note = map['note'];
  }
}
