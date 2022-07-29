import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/paginated_characters.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.character,
    this.onTap,
  }) : super(key: key);

  final Character character;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7.5,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    character.image,
                    width: MediaQuery.of(context).size.width,
                    height: 175,
                    alignment: const Alignment(0.0, -0.5),
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const LinearProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                //top: 0,
                left: 5,
                //right:
                bottom: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16, //14.5
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
