import 'package:countries_app/big_card_page.dart';
import 'package:countries_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatelessWidget {
  final String name;
  final String region;
  final String capital;
  final String flag;
  const CountryCard({
    super.key,
    required this.name,
    required this.region,
    required this.capital,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return InkWell(
      onTap: () {
        appState.getNext(name);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const BigCardPage();
            },
          ),
        );
      },
      child: SizedBox(
        width: 230,
        height: 230,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: const Color.fromARGB(255, 255, 232, 232),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  flag,
                  width: 120,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Region: $region',
                      ),
                      Text(
                        'Capital: $capital',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
