import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Preco extends StatefulWidget {
  const Preco({super.key});

  @override
  State<Preco> createState() => _PrecoState();
}

class _PrecoState extends State<Preco> {

  String _preco = "0";

  void _recuperarPreco()async{
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

    print("Resultado: " + retorno["BRL"]["buy"].toString());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/bitcoin.png"),
            Padding(padding: EdgeInsets.only(top: 40),
            child: Text(
                "R\$ " + _preco,
            style: TextStyle(
              fontSize: 35
            ),
            ),
            ),
            ElevatedButton(onPressed: _recuperarPreco,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                )
              ),
              child: Text("Atualizar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),),
              ),
          ],
        ),
      ),
      ),
    );
  }
}
