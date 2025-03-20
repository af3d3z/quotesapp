import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quotesapp/models/quote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote quote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse("https://qapi.vercel.app/api/random");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      quote = Quote(map['id'], map['quote'], map['author']);
      print("Quote: ${quote.quote}");
      print("Author: ${quote.author}");
    } else {
      quote = Quote(0, "Failed to load quote", "");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            onPressed: () async {
              await fetchQuote();
            },
            child: Text("Get a new quote"),
          )),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Quotes",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.05),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Text(
                          quote.quote.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: Text(
                          "- ${quote.author.toString()}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
