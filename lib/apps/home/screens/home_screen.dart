import 'package:flutter/material.dart';
import 'package:pokemon/apps/home/controllers/home_controller.dart';
import 'package:pokemon/core/screens/screen_base.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Esta variable nos dirá en que modo está la app;
  late bool _isLightMode;

  // Esta será la lógica de esta pantalla
  final HomeController _con = HomeController();

  late Future<dynamic> _future;

  @override
  void initState() {
    _future = _con.getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Seteamos el modo de la app;
    _isLightMode =
        MyInheritedTheme.of(context).data?.brightness == Brightness.light;

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ScreenBase(
          title: 'Cargando...',
          floatingActionButton: _floatingActionButton(),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
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
}
