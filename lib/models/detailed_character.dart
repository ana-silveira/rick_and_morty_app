class DetailedCharacter {
  final int id;
  final String name;
  final String image;
  final String specie; // Humana, Alien, Humanoid, etc
  final String gender;
  final String status; // Dead / Alive / Unknown
  final CharLocation lastLocation;
  final CharLocation originLocation;
  final String firstSeen; //episódio

  DetailedCharacter(
      {required this.id,
      required this.name,
      required this.image,
      required this.specie,
      required this.gender,
      required this.status,
      required this.lastLocation, //location
      required this.originLocation, //origin
      required this.firstSeen});

  factory DetailedCharacter.fromJson(Map<String, dynamic> json) {
    
    String urlEpisode = json["episode"][0];
    List<String> splitted = urlEpisode.split('episode/');

    return DetailedCharacter(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      specie: json['species'],
      gender: json['gender'],
      status: json['status'],
      lastLocation: CharLocation.fromJson(json['location']),
      originLocation: CharLocation.fromJson(json['origin']),
      firstSeen: splitted[1],
    );
  }
}

class CharLocation {
  final String name;
  final String url;

  CharLocation({
    required this.name,
    required this.url
  });
  factory CharLocation.fromJson(Map<String, dynamic> json) => CharLocation(
        name: json['name'],
        url: json['url'],
      );
}
