import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/components/app_bar_component.dart';
import 'package:rick_and_morty_app/components/detailed_char_card.dart';
import 'package:rick_and_morty_app/data/repository.dart';
import 'package:rick_and_morty_app/models/detailed_character.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/characters';

  const DetailsPage({
    Key? key,
    required this.characterId,
  }) : super(key: key);

  final int characterId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedCharacter>? detailedCharacter;

  @override
  void initState() {
    detailedCharacter = Repository.getCharacterDetails(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<DetailedCharacter>(
        future: detailedCharacter,
        builder: (context, AsyncSnapshot<DetailedCharacter> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [
                DetailedCharCard(detailedCharacter: data),
              ],
            );
          } else if (snapshot.hasError) {
            final data = snapshot.error.toString();
            return Center(
              child: Text(
                'Ocorreu um erro aqui. $data',
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
