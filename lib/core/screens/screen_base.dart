import 'package:flutter/material.dart';

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

  /// Determina si encerramos el widget hijo en un scroll.
  final bool wrapInScroll;

  /// Determina la dirección del scroll
  final Axis scrollDirection;

  final FloatingActionButton? floatingActionButton;

  const ScreenBase({
    super.key,
    required this.title,
    required this.child,
    this.paddingMode = ScreenBasePadding.none,
    this.paddingSize = 8.0,
    this.expandBody = false,
    this.floatingActionButton,
    this.wrapInScroll = true,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  /// Widget hijo de esta pantalla;
  late Widget _child;

  @override
  void initState() {
    // Encerramos al widgt hijo dentro de un scroll en caso de ser necesario
    if (widget.wrapInScroll) {
      _child = SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        child: widget.child,
      );
    } else {
      _child = widget.child;
    }

    // Agregamos el margen en caso de ser necesario
    if (widget.paddingMode == ScreenBasePadding.horizontal) {
      _child = Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.paddingSize),
        child: _child,
      );
    } else if (widget.paddingMode == ScreenBasePadding.vertical) {
      _child = Padding(
        padding: EdgeInsets.symmetric(vertical: widget.paddingSize),
        child: _child,
      );
    } else if (widget.paddingMode == ScreenBasePadding.both) {
      _child = Padding(
        padding: EdgeInsets.all(widget.paddingSize),
        child: _child,
      );
    }

    // Hacemos que el widget hijo ocupe toda la pantalla en caso de ser
    // necesario.
    if (widget.expandBody) {
      _child = Column(
        children: [
          Expanded(
              child: Row(
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
