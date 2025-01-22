import 'package:flutter/material.dart';
import 'package:quotesapp/models/quote.dart';
import 'package:quotesapp/screens/home_screen.dart';

class SecondScreen extends StatelessWidget {
  Quote quote;
  SecondScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            Center(
                child: Card(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.05),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: Text(
                      quote.quote.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: Text(
                      "- ${quote.author.toString()}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            )),
            ElevatedButton(
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeScreen()))
                    },
                child: Text("Go back"))
          ],
        ),
      )),
    );
  }
}
