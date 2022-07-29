import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/detailed_character.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class DetailedCharCard extends StatelessWidget {
  const DetailedCharCard({
    Key? key,
    required this.detailedCharacter,
  }) : super(key: key);

  final DetailedCharacter detailedCharacter;
  //final String space = ' - ';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Image.network(
                  detailedCharacter.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
                Text(
                  detailedCharacter.name.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17, //14.5
                  ),
                ),
                const SizedBox(height: 5),
                //height: 15
                Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: <Widget>[
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
                    ]),
                const SizedBox(height: 10),
                const Text(
                  'Last known location: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
                Text(
                  detailedCharacter.lastLocation.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'First seen in: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
                Text(
                  detailedCharacter.firstSeen,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
