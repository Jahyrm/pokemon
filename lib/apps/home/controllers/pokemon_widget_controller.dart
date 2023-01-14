import 'package:pokemon/apps/home/widgets/pokemon_widget.dart';

class PokemonWidgetController {
  late int baseHp, baseAttack, baseDefense, baseSpeed;
  late int hp, attack, defense, speed;
  String? descHabilidad, photoUrl;

  List<HabilidadPokemon> habilidades = [];

  /// Ingresamos o Eliminar una habilidad a la lista, recibe como parámetro la
  /// habilidad. (Tipo [HabilidadPokemon])
  bool toggleHabilidad(HabilidadPokemon habilidadPokemon) {
    if (habilidades.contains(habilidadPokemon)) {
      habilidades.remove(habilidadPokemon);
      _modifyValues(habilidadPokemon, false);
    } else {
      if (habilidades.length < 2) {
        habilidades.add(habilidadPokemon);
        _modifyValues(habilidadPokemon, true);
      } else {
        return false;
      }
    }
    return true;
  }

  /// Modifica los valores correspondientes de acuerdo a cada habilidad escogida
  /// Recibe como parámetro la habilidad y una bandera o boolean que indica
  /// si la habilidad se ingresó o eliminó
  void _modifyValues(HabilidadPokemon habilidadPokemon, bool seAgrego) {
    if (habilidadPokemon == HabilidadPokemon.intimidacion) {
      if (seAgrego) {
        attack += 10;
        speed += 15;
        hp -= 5;
        defense -= 10;
        descHabilidad =
            'Aumenta ataque en 10 y velocidad en 15, reduce vida 5 y defensa en 10';
      } else {
        attack -= 10;
        speed -= 15;
        hp += 5;
        defense += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.regeneracion) {
      if (seAgrego) {
        hp += 10;
        defense += 20;
        attack -= 20;
        speed -= 10;
        descHabilidad =
            'Aumenta vida en 10, defensa en 20, reduce ataque en 20 y velocidad en 10';
      } else {
        hp -= 10;
        defense -= 20;
        attack += 20;
        speed += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.inmunidad) {
      if (seAgrego) {
        attack += 15;
        speed += 15;
        hp -= 20;
        defense -= 10;
        descHabilidad =
            'Aumenta ataque en 15, velocidad en 15, reduce vida en 20 y defensa en 10';
      } else {
        attack -= 15;
        speed -= 15;
        hp += 20;
        defense += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.potencia) {
      if (seAgrego) {
        hp += 10;
        speed += 5;
        defense += 5;
        attack -= 20;
        descHabilidad =
            'Aumenta vida en 10, velocidad en 5 y defensa en 5 reduce ataque 20';
      } else {
        hp -= 10;
        speed -= 5;
        defense -= 5;
        attack += 20;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.impasible) {
      if (seAgrego) {
        speed += 30;
        hp -= 10;
        defense -= 10;
        attack -= 3;
        descHabilidad =
            'Aumenta velocidad en 30, reduce vida en 10, defensa en 10 y ataque en 3';
      } else {
        speed -= 30;
        hp += 10;
        defense += 10;
        attack += 3;
        descHabilidad = null;
      }
    } else {
      if (seAgrego) {
        defense += 20;
        hp -= 15;
        speed -= 3;
        descHabilidad =
            'Aumenta defensa en 20, reduce vida en 15, velocidad en 3 y ataque 0';
      } else {
        defense -= 20;
        hp += 15;
        speed += 3;
        descHabilidad = null;
      }
    }
  }

  /// Ingresamos o Eliminar una habilidad a la lista, recibe como parámetro la
  /// habilidad. (Tipo [HabilidadPokemon])
  bool toggleHabilidadDos(HabilidadPokemon habilidadPokemon) {
    if (habilidades.contains(habilidadPokemon)) {
      habilidades.remove(habilidadPokemon);
      _modifyValuesDos(habilidadPokemon, false);
    } else {
      if (habilidades.length < 2) {
        habilidades.add(habilidadPokemon);
        _modifyValuesDos(habilidadPokemon, true);
      } else {
        return false;
      }
    }
    return true;
  }

  /// Modifica los valores correspondientes de acuerdo a cada habilidad escogida
  /// Recibe como parámetro la habilidad y una bandera o boolean que indica
  /// si la habilidad se ingresó o eliminó
  void _modifyValuesDos(HabilidadPokemon habilidadPokemon, bool seAgrego) {
    if (habilidadPokemon == HabilidadPokemon.intimidacion) {
      if (seAgrego) {
        baseAttack += 10;
        baseSpeed += 15;
        baseHp -= 5;
        baseDefense -= 10;
        descHabilidad =
            'Aumenta ataque en 10 y velocidad en 15, reduce vida 5 y defensa en 10';
      } else {
        baseAttack -= 10;
        baseSpeed -= 15;
        baseHp += 5;
        baseDefense += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.regeneracion) {
      if (seAgrego) {
        baseHp += 10;
        baseDefense += 20;
        baseAttack -= 20;
        baseSpeed -= 10;
        descHabilidad =
            'Aumenta vida en 10, defensa en 20, reduce ataque en 20 y velocidad en 10';
      } else {
        baseHp -= 10;
        baseDefense -= 20;
        baseAttack += 20;
        baseSpeed += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.inmunidad) {
      if (seAgrego) {
        baseAttack += 15;
        baseSpeed += 15;
        baseHp -= 20;
        baseDefense -= 10;
        descHabilidad =
            'Aumenta ataque en 15, velocidad en 15, reduce vida en 20 y defensa en 10';
      } else {
        baseAttack -= 15;
        baseSpeed -= 15;
        baseHp += 20;
        baseDefense += 10;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.potencia) {
      if (seAgrego) {
        baseHp += 10;
        baseSpeed += 5;
        baseDefense += 5;
        baseAttack -= 20;
        descHabilidad =
            'Aumenta vida en 10, velocidad en 5 y defensa en 5 reduce ataque 20';
      } else {
        baseHp -= 10;
        baseSpeed -= 5;
        baseDefense -= 5;
        baseAttack += 20;
        descHabilidad = null;
      }
    } else if (habilidadPokemon == HabilidadPokemon.impasible) {
      if (seAgrego) {
        baseSpeed += 30;
        baseHp -= 10;
        baseDefense -= 10;
        baseAttack -= 3;
        descHabilidad =
            'Aumenta velocidad en 30, reduce vida en 10, defensa en 10 y ataque en 3';
      } else {
        baseSpeed -= 30;
        baseHp += 10;
        baseDefense += 10;
        baseAttack += 3;
        descHabilidad = null;
      }
    } else {
      if (seAgrego) {
        baseDefense += 20;
        baseHp -= 15;
        baseSpeed -= 3;
        descHabilidad =
            'Aumenta defensa en 20, reduce vida en 15, velocidad en 3 y ataque 0';
      } else {
        baseDefense -= 20;
        baseHp += 15;
        baseSpeed += 3;
        descHabilidad = null;
      }
    }
  }
}
