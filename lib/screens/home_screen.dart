import 'package:flutter/material.dart';
import 'package:quotesapp/screens/second_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quotesapp/models/quote.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              Uri url = Uri.parse("https://qapi.vercel.app/api/random");
              var response = await http.get(url);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
              Map<String, dynamic> map = jsonDecode(response.body);
              Quote quote = Quote(map['id'], map['quote'], map['author']);
              print("Quote: ${quote.quote}");
              print("Author: ${quote.author}");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(quote: quote)));
            },
            child: Text("Go to next screen"),
        ),
      ),
    ),
    ); 
  }
}