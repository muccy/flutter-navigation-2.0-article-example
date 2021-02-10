import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_navigation/app_sections/widget.dart';
import 'package:new_navigation/ingredients/detail.dart';
import 'package:new_navigation/ingredients/provider.dart';
import 'package:new_navigation/ingredients/utils.dart';
import 'package:new_navigation/recipes/detail.dart';
import 'package:new_navigation/recipes/provider.dart';
import 'package:new_navigation/recipes/utils.dart';
import 'package:new_navigation/routing/not_found.dart';
import 'package:new_navigation/routing/stack.dart';

class MainRouterDelegate extends RouterDelegate<NavigationStack> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationStack stack;

  @override
  void dispose() {
    stack.removeListener(notifyListeners);
    super.dispose();
  }

  MainRouterDelegate({@required this.stack}) : super() {
    stack.addListener(notifyListeners);
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages(context: context),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        stack.pop();
        return true;
      },
    );
  }

  List<Page> _pages({@required BuildContext context}) => stack.items
      .mapIndexed((e, i) => e.when(
            notFound: () => MaterialPage(child: NotFound()),
            appSection: (id) => MaterialPage(
              key: ValueKey("AppSectionsPage"),
              child: AppSections(selectedSectionId: id),
            ),
            ingredient: (id) {
              final ingredient = id == null ? null : context.read(ingredientsProvider).ingredientWithId(id);
              return MaterialPage(
                key: ValueKey("IngredientDetail_$i"),
                child: IngredientDetail(ingredient: ingredient),
              );
            },
            recipe: (id) {
              final recipe = id == null ? null : context.read(recipesProvider).recipeWithId(id);
              return MaterialPage(
                key: ValueKey("RecipeDetail_$i"),
                child: RecipeDetail(recipe: recipe),
              );
            },
          ))
      .toList();

  @override
  NavigationStack get currentConfiguration => stack;

  @override
  Future<void> setNewRoutePath(NavigationStack configuration) async {
    stack.items = configuration.items;
  }
}

extension _IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
