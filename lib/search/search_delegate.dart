import 'package:flutter/material.dart';
import 'package:mobile_salud/models/index.dart';
import 'package:mobile_salud/widgets/index.dart';
import 'package:provider/provider.dart';

import '../providers/index.dart';

class PregnantSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Registro';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _empyContainer();
    }

    final medicineProvider =
        Provider.of<PregnancyService>(context, listen: false);
    medicineProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: medicineProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Pregnant>> snapshot) {
        if (!snapshot.hasData) return _empyContainer();

        final pregnant = snapshot.data!;

        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: pregnant.length,
            itemBuilder: (BuildContext context, int index) {
              return CardPregnant(pregnant: pregnant[index]);
            });
      },
    );
  }

  Widget _empyContainer() {
    return const Center(
      child: Icon(Icons.medication, color: Colors.black38, size: 130),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _empyContainer();
    }

    final medicineProvider =
        Provider.of<PregnancyService>(context, listen: false);
    medicineProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: medicineProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Pregnant>> snapshot) {
        if (!snapshot.hasData) return _empyContainer();

        final pregnant = snapshot.data!;

        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: pregnant.length,
            itemBuilder: (BuildContext context, int index) {
              return CardPregnant(pregnant: pregnant[index]);
            });
      },
    );
  }
}
