class PaginatedCharacters {
  final Info info;
  final List<Character> results;
  /*name, image, specie, status, lastKnownLocation*/

  PaginatedCharacters({
    required this.info,
    required this.results,
    }
  );
  factory PaginatedCharacters.fromJson(Map<String, dynamic> map) {
    return PaginatedCharacters(
      info: Info.fromJson(map['info'] as Map<String,dynamic>),
      results: List<Character>.from(
        (map['results']?.map((x) => Character.fromJson(x)))),
    );
  }
}

class Character {
  final int id;
  final String name;
  final String image;
  final String specie; // Humana, Alien, Humanoid, etc
  final String status; // Dead / Alive / Unknown
  final Location lastLocation;
  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.specie,
    required this.status,
    required this.lastLocation,
  });
  factory Character.fromJson(Map<String, dynamic> map) {
    return Character(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      specie: map['specie'] ?? '',
      status: map['status'] ?? '',
      lastLocation: Location.fromJson(map['location'] as Map<String,dynamic>),
    );
  }
}

class Info {
  final int count;
  final int pages;
  final String next;
  final String prev;
  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }
  factory Info.fromJson(Map<String, dynamic> map) {
    return Info(
      count: map['count'] ?? 0,
      pages: map['pages'] ?? 0,
      next: map['next'] ?? '',
      prev: map['prev'] ?? '',
    );
  }
}

class Location {
  final String name;
  final String url;
  Location({
    required this.name,
    required this.url,
});
  factory Location.fromJson(Map<String, dynamic> json) => Location(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      );
}

