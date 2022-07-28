import 'package:flutter/material.dart';
import 'package:the_rick_and_morty_api/models/detailed_character.dart';
import 'package:the_rick_and_morty_api/theme/app_colors.dart';

class DetailedCharCard extends StatelessWidget {
  const DetailedCharCard({
    Key? key,
    required this.detailedCharacter,
  }) : super(key: key);

  final DetailedCharacter detailedCharacter;
  final String space = ' - ';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: AppColors.primaryColorLight,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(detailedCharacter.image),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailedCharacter.name.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Chip(
                      //status
                      backgroundColor: (() {
                        switch (detailedCharacter.status) {
                          case "Alive":
                            return AppColorsStatus.alive;
                          case "Dead":
                            return AppColorsStatus.dead;
                          default:
                            return AppColorsStatus.unknown;
                        }
                      }()),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                      side: const BorderSide(color: AppColors.white),
                      label: Text(detailedCharacter.status),
                    ),
                    Chip(
                      //gender
                      backgroundColor: AppColors.primaryColorLight,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                      side: const BorderSide(color: AppColors.white),
                      label: Text(detailedCharacter.gender),
                    ),
                    Chip(
                      //specie
                      backgroundColor: AppColors.primaryColorLight,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                      side: const BorderSide(color: AppColors.white),
                      label: Text(detailedCharacter.specie),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Last known location: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 12.5,
                      ),
                    ),
                    Text(
                      detailedCharacter.lastLocation.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'First seen in: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 12.5,
                      ),
                    ),
                    Text(
                      detailedCharacter.firstSeen,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
