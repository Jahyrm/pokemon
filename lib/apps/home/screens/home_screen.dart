import 'package:flutter/material.dart';
import 'package:pokemon/apps/home/controllers/home_controller.dart';
import 'package:pokemon/apps/home/models/pokemon.dart';
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
        //sp = const AsyncSnapshot<List<Pokemon>?>.withData(ConnectionState.done, []);
        // sp = const AsyncSnapshot<List<Pokemon>?>.withData(ConnectionState.waiting, null);
        // sp = AsyncSnapshot<List<Pokemon>?>.withError(ConnectionState.done, 'some error', StackTrace.current);

        if (sp.connectionState == ConnectionState.done) {
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

  Widget _body(List<Pokemon> lista) {
    return ScreenBase(
      title: Utils.capitalize(lista[_con.selectedIndex].name ?? 'Desconocido'),
      paddingMode: ScreenBasePadding.both,
      expandBody: false,
      floatingActionButton: _floatingActionButton(),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
            Text('Prueba'),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _con.toggleTheme(context, _isLightMode);
      },
      child: Icon(_isLightMode ? Icons.dark_mode : Icons.light_mode),
    );
  }

  ScreenBase _emptyWidget({String? customMessage}) {
    return ScreenBase(
      title: 'Información',
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.info),
            const SizedBox(height: 8.0),
            Text(customMessage ?? 'No se obtuvieron datos.')
          ],
        ),
      ),
    );
  }

  ScreenBase _errorWidget(String errorMessage) {
    return ScreenBase(
      title: 'Error',
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error, color: Colors.red.shade900),
            const SizedBox(height: 8.0),
            Text(errorMessage)
          ],
        ),
      ),
    );
  }

  ScreenBase _loadingWidget() {
    return const ScreenBase(
      title: 'Cargando...',
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
