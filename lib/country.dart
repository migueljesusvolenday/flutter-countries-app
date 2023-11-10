class Country {
  final String name;
  final String region;
  final String capital;
  final String flag;

  Country({
    required this.name,
    required this.region,
    required this.capital,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    List capitalList = json['capital']?.toList() ?? [];
    var stringcapital = "";
    for (var i = 0; i < capitalList.length; i++) {
      stringcapital += capitalList[i];
      stringcapital += " ";
    }

    return Country(
      name: json['name']['common'],
      capital: stringcapital,
      region: json['region'],
      flag: json['flags']['png'],
    );
  }
}
