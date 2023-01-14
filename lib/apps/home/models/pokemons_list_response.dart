class PokemonsUrlListResponse {
  int? count;
  String? next;
  String? previous;
  List<PokemonUrl>? pokemonUrls;

  PokemonsUrlListResponse(
      {this.count, this.next, this.previous, this.pokemonUrls});

  PokemonsUrlListResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      pokemonUrls = <PokemonUrl>[];
      json['results'].forEach((v) {
        pokemonUrls!.add(PokemonUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (pokemonUrls != null) {
      data['results'] = pokemonUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonUrl {
  String? name;
  String? url;

  PokemonUrl({this.name, this.url});

  PokemonUrl.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
