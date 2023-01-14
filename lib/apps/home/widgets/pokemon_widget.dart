import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemon/apps/home/controllers/pokemon_widget_controller.dart';
import 'package:pokemon/apps/home/models/pokemon.dart';
import 'package:transparent_image/transparent_image.dart';

enum HabilidadPokemon {
  intimidacion,
  regeneracion,
  inmunidad,
  potencia,
  impasible,
  toxico,
}

class PokemonWidget extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonWidget({super.key, required this.pokemon});

  @override
  State<PokemonWidget> createState() => _PokemonWidgetState();
}

class _PokemonWidgetState extends State<PokemonWidget> {
  final PokemonWidgetController _con = PokemonWidgetController();

  @override
  void initState() {
    _con.baseHp = widget.pokemon.stats?[0].baseStat ?? 0;
    _con.baseAttack = widget.pokemon.stats?[1].baseStat ?? 0;
    _con.baseDefense = widget.pokemon.stats?[2].baseStat ?? 0;
    _con.baseSpeed = widget.pokemon.stats?[5].baseStat ?? 0;

    _con.hp = 0;
    _con.attack = 0;
    _con.defense = 0;
    _con.speed = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _con.baseHp = widget.pokemon.stats?[0].baseStat ?? 0;
    _con.baseAttack = widget.pokemon.stats?[1].baseStat ?? 0;
    _con.baseDefense = widget.pokemon.stats?[2].baseStat ?? 0;
    _con.baseSpeed = widget.pokemon.stats?[5].baseStat ?? 0;

    if (widget.pokemon.sprites?.other?.officialArtwork?.frontDefault != null) {
      _con.photoUrl =
          widget.pokemon.sprites!.other!.officialArtwork!.frontDefault;
    }
    if (_con.photoUrl == null) {
      if (widget.pokemon.sprites?.other?.home?.frontDefault != null) {
        _con.photoUrl = widget.pokemon.sprites!.other!.home!.frontDefault;
      }
    }
    if (_con.photoUrl == null) {
      if (widget.pokemon.sprites?.frontDefault != null) {
        _con.photoUrl = widget.pokemon.sprites!.frontDefault;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Habilidades',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _customButton(
                              HabilidadPokemon.intimidacion, 'Intimidación'),
                          const SizedBox(width: 8.0),
                          _customButton(
                              HabilidadPokemon.regeneracion, 'Regeneración'),
                          const SizedBox(width: 8.0),
                          _customButton(
                              HabilidadPokemon.inmunidad, 'Inmunidad'),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _customButton(HabilidadPokemon.potencia, 'Potencia'),
                          const SizedBox(width: 8.0),
                          _customButton(
                              HabilidadPokemon.impasible, 'Impasible'),
                          const SizedBox(width: 8.0),
                          _customButton(HabilidadPokemon.toxico, 'Tóxico'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                if (_con.descHabilidad != null) _habilidadInfo(),
                if (_con.photoUrl != null && _con.photoUrl!.isNotEmpty)
                  const SizedBox(height: 8.0),
                if (_con.photoUrl != null && _con.photoUrl!.isNotEmpty)
                  _image(),
                const SizedBox(height: 24.0),
                const Divider(),
                _statsRows(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _customButton(HabilidadPokemon habilidadPokemon, String texto) {
    return Expanded(
      child: ElevatedButton(
        style: _con.habilidades.contains(habilidadPokemon)
            ? ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              )
            : null,
        onPressed: () {
          setState(() {
            _con.toggleHabilidad(habilidadPokemon);
          });
        },
        child: Text(
          texto,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 9),
        ),
      ),
    );
  }

  Column _habilidadInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 2.0),
            Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            const SizedBox(width: 2.0),
            Expanded(
              child: Text(
                'Información de habilidades seleccionada',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 2.0),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          '"${_con.descHabilidad!}"',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Center _image() {
    return Center(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: _con.photoUrl ?? '',
        width: 300,
        height: 200,
      ),
    );
  }

  Column _statsRows() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Vida',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              flex: 3,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.65,
                lineHeight: 20.0,
                percent: (((_con.baseHp + _con.hp) * 100) / 250) / 100,
                center: Text(
                  (_con.baseHp + _con.hp).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                //linearStrokeCap: LinearStrokeCap.roundAll,
                barRadius: const Radius.circular(15.0),
                progressColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Ataque',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              flex: 3,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.65,
                lineHeight: 20.0,
                percent: (((_con.baseAttack + _con.attack) * 100) / 250) / 100,
                center: Text(
                  (_con.baseAttack + _con.attack).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                //linearStrokeCap: LinearStrokeCap.roundAll,
                barRadius: const Radius.circular(15.0),
                progressColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Defensa',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              flex: 3,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.65,
                lineHeight: 20.0,
                percent:
                    (((_con.baseDefense + _con.baseDefense) * 100) / 250) / 100,
                center: Text(
                  (_con.baseDefense + _con.baseDefense).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                barRadius: const Radius.circular(15.0),
                progressColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Velocidad',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              flex: 3,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.65,
                lineHeight: 20.0,
                percent: (((_con.baseSpeed + _con.speed) * 100) / 250) / 100,
                center: Text(
                  (_con.baseSpeed + _con.speed).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                barRadius: const Radius.circular(15.0),
                progressColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
