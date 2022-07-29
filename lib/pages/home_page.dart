import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/components/app_bar_component.dart';
import 'package:rick_and_morty_app/components/char_card.dart';
import 'package:rick_and_morty_app/data/repository.dart';
import 'package:rick_and_morty_app/models/paginated_characters.dart';
import 'package:rick_and_morty_app/pages/details_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PaginatedCharacters>? characters;

  @override
  void initState() {
    //initState inicia os dados! Qdo a page abrir e td começar a funcionar, é o comando dela que vai começar.
    characters = Repository.getAllCharacters();
    super.initState();
  }

  /*@override
  void dispose() {super.dispose();}  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: characters,
        builder: (_, AsyncSnapshot<PaginatedCharacters> snapshot) {
          final dynamic dataResults;

          if (snapshot.hasData) {
            dataResults = snapshot.data!.results;

            return ListView.separated(
              itemBuilder: (_, index) {
                final character = dataResults[index];
                //final character = Character(id: 1, name: 'a', image: 'image', specie: 'specie', status: 'status', lastLocation: null );

                return CharacterCard(
                  character: character,
                  onTap: () => Navigator.of(context).pushNamed(
                    DetailsPage.routeId,
                    arguments: character.id,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 3),
              itemCount: dataResults.length,
            );
          }
          if (snapshot.hasError) {
            dataResults = snapshot.error.toString();

            return Text(
              'Ocorreu um erro aqui. ${snapshot.error}',
              style: const TextStyle(color: AppColors.white),
            );
          }
          return Container();
        },
      ),
    );
  }
}
