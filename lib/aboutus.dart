// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class aboutus extends StatelessWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About us')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Image(
          image: AssetImage('assets/aboutus.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
