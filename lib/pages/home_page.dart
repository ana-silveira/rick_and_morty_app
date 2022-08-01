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
  Future<PaginatedCharacters>? charactersRepo;
  //late PaginatedCharacters charactersRepo;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  late dynamic nextPage;

  List<Character> listCharacters = List.empty();

  @override
  void initState() {
    loading.value = true;
    charactersRepo = Repository.getAllCharacters();
    loading.value = false;
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    super.initState();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent && !loading.value) {
      updateList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  //Atualiza a lista chamando a próxima página
  void updateList() {
    loading.value = true;
    if (nextPage != null) {
      setState(() {
        charactersRepo = Repository.getCharactersPage(nextPage);
      });
    }
    loading.value = false;
  }

  //Junta uma lista de personagem com o novo data results e remove os duplicados
  _setMoreCharacters(dataResults) async {
    setState(() => listCharacters = [
          ...{...listCharacters, ...dataResults}
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarComponent(context),
        backgroundColor: AppColors.backgroundColor,
        body: FutureBuilder(
          future: charactersRepo,
          builder: (context, AsyncSnapshot<PaginatedCharacters> snapshot) {
            final dynamic dataResults;
            final dynamic dataInfos;
            if (snapshot.hasData) {
              dataResults = snapshot.data!.results;
              dataInfos = snapshot.data!.info;
              nextPage = dataInfos.next;
              _setMoreCharacters(dataResults);
              return Stack(children: [
                ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  itemBuilder: (context, index) {
                    return CharacterCard(
                      character: listCharacters[index],
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailsPage.routeId,
                          arguments: listCharacters[index].id,
                        );
                      },
                    );
                  },
                  itemCount: listCharacters.length,
                ),
                loadingIndicatorWidget()
              ]);
            }

            if (snapshot.hasError) {
              dataResults = snapshot.error.toString();
              return Center(
                child: Text(
                  'Parece que ocorreu um erro por aqui... -> ${snapshot.error}',
                  style: const TextStyle(color: AppColors.white),
                ),
              );
            }
            return Container();
          },
        ));
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                          child: SizedBox(
                        width: 40,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ))))
              : Container();
        });
  }
}
