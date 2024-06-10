import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text(
            'Firebase Demo',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(246, 130, 13, 1),
        ),
    );
  }
}