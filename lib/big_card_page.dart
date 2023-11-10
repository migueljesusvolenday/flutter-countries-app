import 'package:countries_app/big_card.dart';
import 'package:flutter/material.dart';

class BigCardPage extends StatelessWidget {
  const BigCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries App'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 100),
          child: const BigCard(),
        ),
      ),
    );
  }
}
