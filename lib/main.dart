import 'package:countries_app/allcountries.dart';
import 'package:countries_app/search_country_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Countries App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 230, 228)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String current = "";

  void getNext(country) {
    current = country;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [const AllCountries(), const SearchCountryPage()];
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
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  label: Text('Country'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: pages[selectedIndex],
          ),
        ],
      ),
    );
  }
}
