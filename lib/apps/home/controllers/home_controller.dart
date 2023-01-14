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
  /// Lista que contendrá los pokemones actuales.
  List<Pokemon>? listaDePokemones;

  /// Variable que contendrá la respuesta con las urls a llamar
  late PokemonsUrlListResponse pokemonsUrlsResponse;

  /// Contadores e indices.
  int habilidadesSeleccionadas = 0, selectedIndex = 0;

  /// Obtenemos una lista de pokemones o nulo, podemos determinar si queremos
  /// que sean pokemones aleatorios o no, estableciendo el parámetro
  /// [randomPokemons]
  Future<List<Pokemon>?> getPokemons(
      {String? url, bool randomPokemons = false}) async {
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
      url ?? '${GlobalVars.apiUrl}/pokemon/',
      data: url == null ? urlParameters : null,
    );

    if (apiResponse != null) {
      pokemonsUrlsResponse = PokemonsUrlListResponse.fromJson(apiResponse);
      if (pokemonsUrlsResponse.pokemonUrls?.isNotEmpty ?? false) {
        if (url != null) {
          selectedIndex = 0;
          listaDePokemones = null;
        }
        for (PokemonUrl pokemonUrl in pokemonsUrlsResponse.pokemonUrls!) {
          if (pokemonUrl.url?.isNotEmpty ?? false) {
            await _addPokemonToList(pokemonUrl.url!);
          }
        }
      }
    }
    return listaDePokemones;
  }

  /// Función que camia de tema de claro a oscuro
  void toggleTheme(BuildContext context, bool isLightMode) {
    if (isLightMode) {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.dark);
    } else {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.light);
    }
  }

  /// Va a agregando cada pokemon consultado a una lista.
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
