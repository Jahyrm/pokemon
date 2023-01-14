class Pokemon {
  int? baseExperience;
  int? height;
  int? id;
  bool? isDefault;
  String? locationAreaEncounters;
  String? name;
  int? order;
  PokemonSprites? sprites;
  List<PokemonStat>? stats;
  int? weight;

  Pokemon(
      {this.baseExperience,
      this.height,
      this.id,
      this.isDefault,
      this.locationAreaEncounters,
      this.name,
      this.order,
      this.sprites,
      this.stats,
      this.weight});

  Pokemon.fromJson(Map<String, dynamic> json) {
    baseExperience = json['base_experience'];
    height = json['height'];
    id = json['id'];
    isDefault = json['is_default'];
    locationAreaEncounters = json['location_area_encounters'];
    name = json['name'];
    order = json['order'];
    sprites = json['sprites'] != null
        ? PokemonSprites.fromJson(json['sprites'])
        : null;
    if (json['stats'] != null) {
      stats = <PokemonStat>[];
      json['stats'].forEach((v) {
        stats!.add(PokemonStat.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_experience'] = baseExperience;
    data['height'] = height;
    data['id'] = id;
    data['is_default'] = isDefault;
    data['location_area_encounters'] = locationAreaEncounters;
    data['name'] = name;
    data['order'] = order;
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    data['weight'] = weight;
    return data;
  }
}

class PokemonSprites {
  String? frontDefault;
  OtherPokemonSprites? other;

  PokemonSprites({this.frontDefault, this.other});

  PokemonSprites.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    other = json['other'] != null
        ? OtherPokemonSprites.fromJson(json['other'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class OtherPokemonSprites {
  PokemonSprite? home;
  PokemonSprite? officialArtwork;

  OtherPokemonSprites({this.home, this.officialArtwork});

  OtherPokemonSprites.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? PokemonSprite.fromJson(json['home']) : null;
    officialArtwork = json['official-artwork'] != null
        ? PokemonSprite.fromJson(json['official-artwork'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (officialArtwork != null) {
      data['official-artwork'] = officialArtwork!.toJson();
    }
    return data;
  }
}

class PokemonSprite {
  String? frontDefault;

  PokemonSprite({this.frontDefault});

  PokemonSprite.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}

class PokemonStat {
  int? baseStat;
  int? effort;

  PokemonStat({this.baseStat, this.effort});

  PokemonStat.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_stat'] = baseStat;
    data['effort'] = effort;
    return data;
  }
}
