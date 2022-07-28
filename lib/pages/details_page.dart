import 'package:flutter/material.dart';
import 'package:the_rick_and_morty_api/components/app_bar_component.dart';
import 'package:the_rick_and_morty_api/data/repository.dart';
import 'package:the_rick_and_morty_api/models/detailed_character.dart';
import 'package:the_rick_and_morty_api/theme/app_colors.dart';
import 'package:the_rick_and_morty_api/components/detailed_char_card.dart';

class DetailsPage extends StatefulWidget {
  final int characterId;

  static const routeId = '/characters/';

  const DetailsPage({
    Key? key,
    required this.characterId,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class Controller {
  final character = ValueNotifier<DetailedCharacter?>(null);
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedCharacter>? character;
  @override
  void initState() {
    character = Repository.getCharacterDetails(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarComponent(context, isSecondPage: true),
        backgroundColor: AppColors.backgroundColor,
        body: FutureBuilder<DetailedCharacter>(
            future: character,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return DetailedCharCard(detailedCharacter: data);
              } else if (snapshot.hasError) {
                final data = snapshot.error.toString();
                return Text(
                  'Ocorreu um erro aqui. $data',
                  style: const TextStyle(color: AppColors.white),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
