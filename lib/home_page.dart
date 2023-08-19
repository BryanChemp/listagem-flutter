import 'dart:convert';
import 'package:flutter/material.dart';
import 'Item.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  late Future<List<Item>> itens;

  @override
  void initState() {
    super.initState();
    itens = getItem();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: const Color(0xff6ae792),
      // ignore: prefer_const_constructors
        title: Center (
          child: const Text(
                  'Listando',
                  style: 
                    TextStyle(color: Colors.black),
                    
                                 
                          ),
      ),),
      // ignore: prefer_const_constructors
      body: Center(
        child: FutureBuilder(
          future: itens,
          builder: (context, snapshot){
            if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    Item item = snapshot.data![index];
                    return Container(
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xff6ae792),
                          child: Text( 
                            item.id.toString(),
                            style: const TextStyle(color: Colors.black),),),
                        title: Text(item.nome.toString()),
                        subtitle: Text('Lote: ${item.lotes.toString()}'),
                      ));
                  });

            }else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          } ,
        ),
      ),
    );
  }

  Future<List<Item>> getItem() async {
    var url = Uri.parse('https://api.kleiloes.com.br/tipo-bem/ativos');
    var response = await http.get(url);
    if(response.statusCode == 200) {
      List listaItens = json.decode(response.body);
      return listaItens.map((json) => Item.fromJson(json)).toList();
    }else {
      throw Exception('Erro: não foi possível carregar os usuários.');
    }
  } 
}