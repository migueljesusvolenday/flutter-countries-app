import 'package:countries_app/big_card.dart';
import 'package:flutter/material.dart';

class BigCardPage extends StatelessWidget {
  const BigCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where in the world?'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {},
          ),
        ],
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
