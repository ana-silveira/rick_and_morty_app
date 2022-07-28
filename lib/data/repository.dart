import 'package:dio/dio.dart';
import 'package:the_rick_and_morty_api/models/detailed_character.dart';
import 'package:the_rick_and_morty_api/models/paginated_characters.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
    ),
  );

  static Future<PaginatedCharacters> getAllCharacters() async {
    final response = await _dio.get('/character');

    final data = PaginatedCharacters.fromJson(response.data);

    return data;
  }

  static Future<DetailedCharacter> getCharacterDetails(int characterId) async {
    final response = await _dio.get('/character/$characterId');

    final data = DetailedCharacter.fromJson(response.data);

    return data;
  }
}
