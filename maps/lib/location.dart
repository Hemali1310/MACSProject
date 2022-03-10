class Locs {
  final List<Locations> locations;

  Locs({required this.locations});

  factory Locs.fromJson(Map<String, dynamic> json) {
    return Locs(
      locations: parseLocation(json),
    );
  }

  static List<Locations> parseLocation(locationJson) {
    var loclist = locationJson['locations'] as List;
    List<Locations> locslists =
        loclist.map((e) => Locations.fromJson(e)).toList();
    return locslists;
  }
}

class Locations {
  final double latitude;
  final double longitude;
  final String marketId;

  Locations({
    required this.latitude,
    required this.longitude,
    required this.marketId,
  });

  factory Locations.fromJson(Map<String, dynamic> parsedJson) {
    return Locations(
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      marketId: parsedJson['marketId'],
    );
  }
}



// class Locations {

//   List<Latlongs> locations;
    
//   Locations({
//     required this.locations,
//   });

//   factory Locations.fromJson()  
// }

// class Latlongs {
//     Latlongs({
//         required this.latitude,
//         required this.longitude,
//     });

//     double latitude;
//     double longitude;
// }
