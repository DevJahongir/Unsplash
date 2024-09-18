import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _callNextPage(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }


  _initTimer(){
    Timer(const Duration(seconds: 2), (){
      _callNextPage();
    });
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(19, 41, 116, 1.0),
              Color.fromRGBO(41, 62, 115, 1.0),
            ]
          )
        ),
        child: const Column(
          children: [
            Expanded(child: Center(
              child: Text(
                "Unsplash",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Metroplex Shadow"
                ),
              ),
            )
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
