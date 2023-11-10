class CountryBigCard {
  final String name;
  final String capital;
  final String region;
  final String subregion;
  final int population;
  final double area;
  final String flag;

  CountryBigCard({
    required this.name,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.area,
    required this.flag,
  });

  factory CountryBigCard.fromJson(Map<String, dynamic> json) {
    List capitalList = json['capital']?.toList() ?? [];
    var stringcapital = "";
    for (var i = 0; i < capitalList.length; i++) {
      stringcapital += capitalList[i];
      stringcapital += " ";
    }
    return CountryBigCard(
      name: json['name']['common'],
      capital: stringcapital,
      region: json['region'],
      subregion: json['subregion']?.toString() ?? "",
      population: json['population'],
      area: json['area'],
      flag: json['flags']['png'],
    );
  }
}
