import 'package:flutter/material.dart';
import 'package:pokemon/apps/home/controllers/home_controller.dart';
import 'package:pokemon/apps/home/models/pokemon.dart';
import 'package:pokemon/apps/home/widgets/pokemon_widget.dart';
import 'package:pokemon/core/screens/connection_info_screen.dart';
import 'package:pokemon/core/screens/screen_base.dart';
import 'package:pokemon/core/utils/utils.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Esta será la lógica de esta pantalla
  final HomeController _con = HomeController();

  /// Esta variable nos dirá en que modo está la app;
  late bool _isLightMode;

  /// Future para traer los datos desde la base
  late Future<List<Pokemon>?> _future;

  @override
  void initState() {
    _future = _con.getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Seteamos el modo de la app;
    _isLightMode =
        MyInheritedTheme.of(context).data?.brightness == Brightness.light;

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<List<Pokemon>?> sp) {
        // sp = const AsyncSnapshot<List<Pokemon>?>.withData(ConnectionState.done, null);
        // sp = const AsyncSnapshot<List<Pokemon>?>.withData(ConnectionState.done, []);
        // sp = const AsyncSnapshot<List<Pokemon>?>.withData(ConnectionState.waiting, null);
        // sp = AsyncSnapshot<List<Pokemon>?>.withError(ConnectionState.done, 'some error', StackTrace.current);
        if (sp.connectionState != ConnectionState.waiting) {
          if (sp.hasData) {
            if (sp.data!.isNotEmpty && sp.data!.length == 3) {
              return _body(sp.data!);
            } else {
              return const ConnectionInfoScreen(type: ConnectionInfo.empty);
            }
          } else {
            return ConnectionInfoScreen(
              type: ConnectionInfo.error,
              customMessage: sp.error?.toString(),
            );
          }
        } else {
          return const ConnectionInfoScreen(type: ConnectionInfo.loading);
        }
      },
    );
  }

  ScreenBase _body(List<Pokemon> lista) {
    return ScreenBase(
      title: Utils.capitalize(lista[_con.selectedIndex].name ?? 'Desconocido'),
      paddingMode: ScreenBasePadding.both,
      floatingActionButton: _floatingActionButton(),
      actionToDoIfReachEdge: () async {
        if (_con.pokemonsUrlsResponse.next?.isNotEmpty ?? false) {
          // await _con.getPokemons(url: _con.pokemonsUrlsResponse.next);
          setState(() {
            _future = _con.getPokemons(url: _con.pokemonsUrlsResponse.next);
          });
        }
      },
      child: Column(
        children: [
          _tabs(lista),
          const SizedBox(height: 24.0),
          Visibility(
            maintainState: true,
            visible: _con.selectedIndex == 0,
            child: PokemonWidget(
              pokemon: lista[0],
            ),
          ),
          Visibility(
            maintainState: true,
            visible: _con.selectedIndex == 1,
            child: PokemonWidget(
              pokemon: lista[1],
            ),
          ),
          Visibility(
            maintainState: true,
            visible: _con.selectedIndex == 2,
            child: PokemonWidget(
              pokemon: lista[2],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Padding _tabs(List<Pokemon> lista) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: leftTab(lista[0].name),
          ),
          Expanded(
            child: centerTab(lista[1].name),
          ),
          Expanded(
            child: rightTab(lista[2].name),
          )
        ],
      ),
    );
  }

  InkWell leftTab(String? name) {
    return InkWell(
      onTap: () {
        setState(() {
          _con.selectedIndex = 0;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          color: _con.selectedIndex == 0
              ? Theme.of(context).primaryColor
              : Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            Utils.capitalize(name ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _con.selectedIndex == 0
                  ? Colors.white
                  : Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }

  InkWell centerTab(String? name) {
    return InkWell(
      onTap: () {
        setState(() {
          _con.selectedIndex = 1;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          color: _con.selectedIndex == 1
              ? Theme.of(context).primaryColor
              : Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            Utils.capitalize(name ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _con.selectedIndex == 1
                  ? Colors.white
                  : Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }

  InkWell rightTab(String? name) {
    return InkWell(
      onTap: () {
        setState(() {
          _con.selectedIndex = 2;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          color: _con.selectedIndex == 2
              ? Theme.of(context).primaryColor
              : Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            Utils.capitalize(name ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _con.selectedIndex == 2
                  ? Colors.white
                  : Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        _con.toggleTheme(context, _isLightMode);
      },
      child: Icon(_isLightMode ? Icons.dark_mode : Icons.light_mode),
    );
  }
}
