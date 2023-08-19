class Item {
  int? id;
  String? nome;
  int? lotes;

  Item({this.id, this.nome, this.lotes});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    lotes = json['lotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['lotes'] = lotes;
    return data;
  }
}