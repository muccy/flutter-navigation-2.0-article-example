import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_navigation/app_sections/model.dart';
import 'package:new_navigation/ingredients/provider.dart';
import 'package:new_navigation/ingredients/utils.dart';
import 'package:new_navigation/recipes/provider.dart';
import 'package:new_navigation/recipes/utils.dart';
import 'package:new_navigation/routing/delegate.dart';
import 'package:new_navigation/routing/parser.dart';
import 'package:new_navigation/routing/stack.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Builder(
        builder: (context) => MaterialApp.router(
          routerDelegate: MainRouterDelegate(stack: context.read(navigationStackProvider)),
          routeInformationParser: MainRouterInformationParser(
            isValidIngredientId: (id) => id != null && context.read(ingredientsProvider).ingredientWithId(id) != null,
            isValidRecipeId: (id) => id != null && context.read(recipesProvider).recipeWithId(id) != null,
          ),
        ),
      ),
    );
  }
}

final navigationStackProvider = ChangeNotifierProvider((ref) => NavigationStack([
      NavigationStackItem.appSection(id: AppSection.ingredients().id),
    ]));
