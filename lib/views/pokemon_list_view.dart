import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_bloc.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_event.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_state.dart';
import 'package:pokedex_v1_0_0/commons/pikachu_loading.dart';
import 'package:pokedex_v1_0_0/commons/pokemon_details_modal.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/repositories/pokemon_repository.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/views/error_view.dart';
import 'package:pokedex_v1_0_0/widgets/pokemon_list_item.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController scrollController = ScrollController();
  late PokemonBloc pokemonBloc;
  int itemsPerPage = 10;
  bool isLoading = false;
  List<Pokemon> displayedPokemonList = [];
  bool showRefreshIndicator = false;
  double previousScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.add(const FetchPokemons());
    scrollController.addListener(() {
      if (!isLoading &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        previousScrollPosition = scrollController.position.pixels;
        _refreshPokemons(offset: displayedPokemonList.length);
      }
    });
    pokemonBloc.stream.listen((state) {
      if (state is PokemonLoaded) {
        setState(() {
          displayedPokemonList.addAll(state.pokemons);
          isLoading = false;
          showRefreshIndicator = false;
          if (previousScrollPosition > 0) {
            scrollController.jumpTo(previousScrollPosition);
            previousScrollPosition = 0.0;
          }
        });
      } else if (state is PokemonLoading) {
        setState(() {
          isLoading = true;
          showRefreshIndicator = true;
        });
      }
    });
  }

  void _showPokemonDetailsModal(BuildContext context, Pokemon pokemon) async {
    final repository = PokemonRepository();
    final detailedPokemon = await repository.fetchPokemonDetails(pokemon.id);
    final description = await repository.fetchPokemonDescription(pokemon.id);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return PokemonDetailsModal(
              pokemon: detailedPokemon, description: description);
        });
  }

  Future<Pokemon> _fetchPokemonDetails(int id) async {
    final repository = PokemonRepository();
    final pokemon = await repository.fetchPokemonDetails(id);
    return pokemon;
  }

  Future<void> _refreshPokemons({int offset = 0}) async {
    setState(() {
      isLoading = true;
      showRefreshIndicator = true;
    });
    pokemonBloc.add(FetchPokemons(offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTItle)),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && displayedPokemonList.isEmpty) {
            return const Center(child: PikachuLoading());
          } else if (state is PokemonError) {
            return ErrorView(errorMessage: state.message);
          } else {
            return Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: displayedPokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = displayedPokemonList[index];
                    return GestureDetector(
                        onTap: () {
                          _showPokemonDetailsModal(context, pokemon);
                        },
                        child: PokemonListItem(pokemon: pokemon));
                  },
                ),
                if (showRefreshIndicator)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      child: const PikachuLoading(),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
