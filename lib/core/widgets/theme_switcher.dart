import 'package:flutter/material.dart';

/// Este widget es el que se utiliza para definir los datos iniciales del tema
/// y la función que cambia el tema, la cual puede ser llamada en cualquier
/// parte de la app.
class ThemeSwitcher extends StatefulWidget {
  final ThemeData initialTheme;
  final Widget child;

  const ThemeSwitcher({
    super.key,
    required this.initialTheme,
    required this.child,
  });

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  /// Será el tema actuial de la aplicación.
  late ThemeData themeData;

  @override
  void initState() {
    // Se establece el tema actual de la app.
    themeData = widget.initialTheme;
    super.initState();
  }

  /// Definimos la función que se debe ejcutar para cambiar el tema de la app.
  void switchTheme(ThemeData theme) {
    setState(() {
      themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedTheme(
      data: themeData,
      changeThemeFunction: switchTheme,
      child: widget.child,
    );
  }
}

/// Esta clase contiene todas las propiedades que heredarán los widgets hijos.
/// Como podemos ver son finales, no se pueden reinicializar, pero si podemos
/// ejecutar la funcion callback [changeThemeFunction] para ejecutar la función
/// que nos proviene del widget [ThemeSwitcher] y cambiar el tema y cambiar
/// los datos a este widget.
class MyInheritedTheme extends InheritedWidget {
  final ThemeData? data;
  final void Function(ThemeData theme) changeThemeFunction;

  const MyInheritedTheme(
      {super.key,
      this.data,
      required Widget child,
      required this.changeThemeFunction})
      : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedTheme oldWidget) => data != oldWidget.data;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  static MyInheritedTheme of(BuildContext context) {
    final MyInheritedTheme? result = maybeOf(context);
    assert(result != null, 'No InheritedTheme found in context');
    return result!;
  }

  static MyInheritedTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedTheme>();
  }
}
