import 'dart:convert';

class RickMortyCharactersQuery {
  QueryInfo info;
  List<CharacterData> results;

  RickMortyCharactersQuery({
    required this.info,
    required this.results,
  });

  factory RickMortyCharactersQuery.fromRawJson(String str) =>
      RickMortyCharactersQuery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RickMortyCharactersQuery.fromJson(Map<String, dynamic> json) =>
      RickMortyCharactersQuery(
        info: QueryInfo.fromJson(json["info"]),
        results: List<CharacterData>.from(
            json["results"].map((x) => CharacterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class QueryInfo {
  int count;
  int pages;
  String next;
  String? prev;

  QueryInfo({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  factory QueryInfo.fromRawJson(String str) =>
      QueryInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QueryInfo.fromJson(Map<String, dynamic> json) => QueryInfo(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class CharacterData {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Location origin;
  Location location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  CharacterData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterData.fromRawJson(String str) =>
      CharacterData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterData.fromJson(Map<String, dynamic> json) => CharacterData(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
