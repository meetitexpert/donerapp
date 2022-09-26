// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class aboutus extends StatelessWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About us')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Image(
              image: AssetImage('assets/aboutus.jpeg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Flexible(child: Text('Developed by B-Technos', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),))
        ],
      ),
    );
  }
}
