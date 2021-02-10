import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_navigation/app.dart';
import 'package:new_navigation/app_sections/model.dart';
import 'package:new_navigation/ingredients/list.dart';
import 'package:new_navigation/recipes/list.dart';
import 'package:new_navigation/routing/stack.dart';

class AppSections extends StatelessWidget {
  final appSections = [AppSection.ingredients(), AppSection.recipes()];
  final String selectedSectionId;

  AppSections({Key key, @required this.selectedSectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedSectionIndex = appSections.indexWhere((e) => e.id == selectedSectionId);
    final selectedSection = appSections[selectedSectionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedSection.name),
      ),
      body: selectedSection.when(
        ingredients: () => Ingredients(),
        recipes: () => Recipes(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: appSections
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.name,
                ))
            .toList(),
        currentIndex: selectedSectionIndex,
        onTap: (value) {
          final appSection = appSections[value];
          context.read(navigationStackProvider).items = [NavigationStackItem.appSection(id: appSection.id)];
        },
      ),
    );
  }
}
