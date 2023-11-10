import 'package:countries_app/countrybigcard.dart';
import 'package:countries_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key});

  @override
  Widget build(BuildContext context) {
    var mainAxisAlignment = MainAxisAlignment.spaceEvenly;
    var appState = context.watch<MyAppState>();
    var country = appState.current;
    Axis direction;
    double width;
    double imageWidth;
    double padding;

    Future<CountryBigCard> fetchCountry() async {
      final response = await http.get(Uri.parse(
          'https://restcountries.com/v3.1/translation/$country?fields=name,region,subregion,capital,currencies,area,population,languages,flags'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // Convertir la respuesta en una lista de objetos json
        final List<dynamic> jsonList = jsonDecode(response.body);

// Convertir la lista de objetos json en una lista de objetos Album
        final List<CountryBigCard> countries =
            jsonList.map((json) => CountryBigCard.fromJson(json)).toList();
        var country = countries[0];
        return country;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    }

    if (MediaQuery.of(context).size.width > 700) {
      direction = Axis.horizontal;
      mainAxisAlignment = MainAxisAlignment.spaceEvenly;
      width = 700;
      imageWidth = 300;
      padding = 30;
    } else {
      mainAxisAlignment = MainAxisAlignment.start;
      direction = Axis.vertical;
      width = 300;
      imageWidth = 230;
      padding = 10;
    }

    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: FutureBuilder<CountryBigCard>(
                future: fetchCountry(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Flex(
                      direction: direction,
                      mainAxisAlignment: mainAxisAlignment,
                      children: [
                        Image.network(
                          snapshot.data!.flag,
                          width: imageWidth,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child:
                                  Text("Capital : ${snapshot.data!.capital}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Region : ${snapshot.data!.region}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  "Subregion : ${snapshot.data!.subregion}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  "Population : ${snapshot.data!.population}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Area : ${snapshot.data!.area} km²"),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
