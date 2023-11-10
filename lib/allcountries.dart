import 'package:countries_app/country.dart';
import 'package:countries_app/country_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AllCountries extends StatefulWidget {
  const AllCountries({
    super.key,
  });

  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  final TextEditingController regionController = TextEditingController();
  var filter = "all";

  Future<List<Country>> fetchCountries(filter) async {
// Hacer la petición HTTP usando el paquete http
    String url;
    if (filter == "all") {
      url =
          'https://restcountries.com/v3.1/all?fields=name,capital,region,subregion,flags';
    } else {
      url =
          'https://restcountries.com/v3.1/region/$filter?fields=name,capital,region,subregion,flags';
    }
    final response = await http.get(Uri.parse(url));

// Comprobar si la respuesta fue exitosa
    if (response.statusCode == 200) {
// Convertir la respuesta en una lista de objetos json
      final List<dynamic> jsonList = jsonDecode(response.body);

// Convertir la lista de objetos json en una lista de objetos Album
      final List<Country> countries =
          jsonList.map((json) => Country.fromJson(json)).toList();

// Devolver la lista de objetos Album
      return countries;
    } else {
// Lanzar una excepción si la respuesta fue fallida
      throw Exception('Failed to load albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> dropdownMenuEntries = const [
      DropdownMenuEntry(value: 'africa', label: "Africa"),
      DropdownMenuEntry(value: 'america', label: "America"),
      DropdownMenuEntry(value: 'asia', label: "Asia"),
      DropdownMenuEntry(value: 'europe', label: "Europe"),
      DropdownMenuEntry(value: 'oceania', label: "Oceania"),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 80),
              child: Column(
                children: [
                  const Text(
                    "Filter by Region",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownMenu(
                    dropdownMenuEntries: dropdownMenuEntries,
                    label: const Text("Region"),
                    controller: regionController,
                    onSelected: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                  ),
                ],
              )),
          Center(
            child: FutureBuilder<List<Country>>(
              future: fetchCountries(filter),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        CountryCard(
                          name: snapshot.data![i].name,
                          region: snapshot.data![i].region,
                          capital: snapshot.data![i].capital,
                          flag: snapshot.data![i].flag,
                        ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
