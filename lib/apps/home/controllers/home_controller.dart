import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:pokemon/core/configs/global_vars.dart';
import 'package:pokemon/core/configs/themes.dart';
import 'package:pokemon/core/services/api.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

/// Clase que contiene todas las acciones de la pantalla principal.
class HomeController {
  Future<dynamic> getPokemons({bool randomPokemons = true}) async {
    // Agregamos datos que irán comio parámetros en la URL
    Map<String, dynamic> urlParameters = {'limit': 3};

    // Comprobamos si queremos pokemons aleatorios
    if (randomPokemons) {
      int numPage = Random().nextInt(425) + 1;
      if (numPage > 0 && numPage < 426) {
        numPage *= 3;
        print(numPage.toString());
        urlParameters['offset'] = numPage;
      }
    }
    // Hacemos la llamada a la api para cargar la lista de 3 pokemones
    Map<String, dynamic>? apiResponse = await Api.call(
      '${GlobalVars.apiUrl}/pokemon/',
      data: urlParameters,
    );

    if (apiResponse != null) {}
    return null;
  }

  void toggleTheme(BuildContext context, bool isLightMode) {
    if (isLightMode) {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.dark);
    } else {
      MyInheritedTheme.of(context).changeThemeFunction(AppThemes.light);
    }
  }
}
