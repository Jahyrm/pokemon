import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon/apps/home/models/pokemon.dart';
import 'package:pokemon/apps/home/models/pokemons_list_response.dart';
import 'package:pokemon/core/configs/global_vars.dart';
import 'package:pokemon/core/configs/themes.dart';
import 'package:pokemon/core/services/api.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

/// Clase que contiene todas las acciones de la pantalla principal.
class HomeController {
  List<Pokemon>? listaDePokemones;
  late PokemonsUrlListResponse pokemonsUrlsResponse;

  int habilidadesSeleccionadas = 0, selectedIndex = 1;

  /// Obtenemos una lista de pokemones o nulo, podemos determinar si queremos
  /// que sean pokemones aleatorios o no, estableciendo el parámetro
  /// [randomPokemons]
  Future<List<Pokemon>?> getPokemons({bool randomPokemons = false}) async {
    // Agregamos datos que irán como parámetros en la URL
    Map<String, dynamic> urlParameters = {'limit': 3};

    // Comprobamos si queremos pokemons aleatorios
    if (randomPokemons) {
      int numPage = Random().nextInt(425) + 1;
      if (numPage > 0 && numPage < 426) {
        numPage *= 3;
        urlParameters['offset'] = numPage;
      }
    }
    // Hacemos la llamada a la api para cargar la lista de 3 pokemones
    Map<String, dynamic>? apiResponse = await Api.call(
      '${GlobalVars.apiUrl}/pokemon/',
      data: urlParameters,
    );

    if (apiResponse != null) {
      pokemonsUrlsResponse = PokemonsUrlListResponse.fromJson(apiResponse);
      if (pokemonsUrlsResponse.pokemonUrls?.isNotEmpty ?? false) {
        for (PokemonUrl pokemonUrl in pokemonsUrlsResponse.pokemonUrls!) {
          if (pokemonUrl.url?.isNotEmpty ?? false) {
            await _addPokemonToList(pokemonUrl.url!);
          }
        }
      }
    }
    return listaDePokemones;
  }

  void toggleTheme(BuildContext context, bool isLightMode) {
    if (isLightMode) {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.dark);
    } else {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.light);
    }
  }

  Future<void> _addPokemonToList(String pokemonUrl) async {
    // Hacemos la llamada a la api para cargar la info de un pokemon
    Map<String, dynamic>? apiResponse = await Api.call(pokemonUrl);
    if (apiResponse != null) {
      listaDePokemones ??= [];
      Pokemon currentPokemon = Pokemon.fromJson(apiResponse);
      listaDePokemones!.add(currentPokemon);
    }
  }
}
