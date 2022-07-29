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
    characters = Repository.getAllCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: characters,
        builder: (context, AsyncSnapshot<PaginatedCharacters> snapshot) {
          final dynamic dataResults;
          if (snapshot.hasData) {
            dataResults = snapshot.data!.results;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: dataResults[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: dataResults[index].id,
                    );
                  },
                );
              },
              itemCount: dataResults.length,
            );
          } else if (snapshot.hasError) {
            dataResults = snapshot.error.toString();
            return Center(
              child: Text(
                'Parece que ocorreu um erro por aqui... -> ${snapshot.error}',
                style: const TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
