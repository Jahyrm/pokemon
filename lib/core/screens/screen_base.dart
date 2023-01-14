import 'package:flutter/material.dart';
import 'package:pokemon/core/configs/themes.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

enum ScreenBasePadding { none, horizontal, vertical, both }

/// Este widget será la base de todas las pantallas de la aplicación, así nos
/// aseguramos que todas sean muy parecidas, y se personalizen por medio de las
/// propiedades. Por lo tanto un cambio que se realice aquí, se refleja en todas
/// las pantallas de la app que utilicen este widget, como base.
///
/// Los parámetros que se necesitan para personalizarlo, se irán agregando sobre
/// la marcha.
class ScreenBase extends StatefulWidget {
  /// Será el título que se muestra en el medio del AppBar
  final String title;

  /// Será el cuerpo de la pantalla, y será diferente en cada pantalla
  final Widget child;

  /// En este parámetro enviaremos si deseamos que el cuerpo de la pantala.
  /// Si no se envía, no se agregará ningún padding.
  final ScreenBasePadding paddingMode;

  /// Tamaño del margen a aplicar en caso de ser necesario
  final double paddingSize;

  /// Determina si el widget hijo debe ocupar toda la pantalla.
  final bool expandBody;

  final FloatingActionButton? floatingActionButton;

  const ScreenBase({
    super.key,
    required this.title,
    required this.child,
    this.paddingMode = ScreenBasePadding.none,
    this.paddingSize = 8.0,
    this.expandBody = false,
    this.floatingActionButton,
  });

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  /// Widget hijo de esta pantalla;
  late Widget _child;

  @override
  void initState() {
    // Agregamos el margen en caso de ser necesario
    if (widget.paddingMode == ScreenBasePadding.none) {
      _child = widget.child;
    } else if (widget.paddingMode == ScreenBasePadding.horizontal) {
      _child = Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.paddingSize),
        child: widget.child,
      );
    } else if (widget.paddingMode == ScreenBasePadding.vertical) {
      _child = Padding(
        padding: EdgeInsets.symmetric(vertical: widget.paddingSize),
        child: widget.child,
      );
    } else {
      _child = Padding(
        padding: EdgeInsets.all(widget.paddingSize),
        child: widget.child,
      );
    }

    // Hacemos que el widget hijo ocupe toda la pantalla en caso de ser
    // necesario.
    if (widget.expandBody) {
      _child = Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: _child),
            ],
          )),
        ],
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _child,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }
}
